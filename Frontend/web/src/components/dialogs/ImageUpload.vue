<template>
  <v-dialog v-model="dialog" width="auto">
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        class="mr-2 rounded-xl button"
        small
        color="#78C4D4"
        outlined
        dark
        v-bind="attrs"
        v-on="on"
      >
        <v-icon small class="mr-2">fas fa-camera</v-icon>
        Alterar fotografia
      </v-btn>
    </template>
    <v-card>
      <v-container>
        <v-card-title>Alterar fotografia</v-card-title>
        <v-divider></v-divider>
        <v-card-text>
          <div class="ml-auto">
            <input
              type="file"
              id="file"
              ref="file"
              v-on:change="handleFileUpload()"
              :rules="rules"
            />
          </div>
          <div>
            <p class="infos font-weight-bold mt-3">Preview</p>
            <v-img
              :src="imageUrl"
              class="ml-2 ml-sm-6"
              style="border: 1px dashed #ccc"
              height="250"
              width="250"
              contain
            />
          </div>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-row align="end" justify="end">
            <v-col cols="auto">
              <Cancel :dialogs="cancelar" @clicked="close()"></Cancel>
            </v-col>
            <v-col cols="auto" class="pl-0">
              <v-btn
                dense
                color="#78c4d4"
                class="rounded-lg white--text"
                required
                type="submit"
                @click="upload()"
                :disabled="!valid"
                >Confirmar</v-btn
              >
            </v-col>
          </v-row>
        </v-card-actions>
      </v-container>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  props: ["id"],
  name: "upload-image",
  data() {
    return {
      dialog: false,
      valid: false, 
      image: null,
      file: "",
      imageUrl: "",
      cancelar: {
        title: "a alteração da sua fotografia",
        text: "a alteração da sua fotografia",
      },
      rules: [
        (file) =>
          !file || (file.size > 102400) || "Avatar size should be less than 100 KB!",
      ],
    };
  },
  components: {
    Cancel: () => import("@/components/dialogs/Cancel"),
  },
  methods: {
    createImage(file) {
      const reader = new FileReader();

      reader.onload = (e) => {
        this.imageUrl = e.target.result;
      };
      reader.readAsDataURL(file);
    },
    close() {
      this.imageUrl = "";
      this.image = null;
      this.dialog = false;
    },
    handleFileUpload() {
      this.file = this.$refs.file.files[0];

      if (this.file.size < 102400){
        this.url = URL.createObjectURL(this.file);
        this.createImage(this.file);
        this.valid = true; 
      }
      else{
        this.$snackbar.showMessage({
          show: true,
          color: "warning",
          text: "A fotografia ultrapassa o limite de tamanho!",
          timeout: 4000,
        });
      }
    },
    upload: async function () {
      let formData = new FormData();

      formData.append("token", store.getters.token);
      formData.append("image", this.file);

      try {
        await axios.put(
          "http://localhost:9040/users/updatePhoto",
          formData,
          {}
        );
        this.dialog = false;
        this.$emit("clicked", "uploaded");
        this.$snackbar.showMessage({
          show: true,
          text: "Imagem atualizada com sucesso.",
          color: "success",
          snackbar: true,
          timeout: 4000,
        });
      } catch (e) {
        console.log(e);
        this.$snackbar.showMessage({
          show: true,
          color: "warning",
          text: "Ocorreu um erro no processamento, por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
  },
};
</script>

<style scoped>
.infos {
  color: #797878;
  text-align: justify;
  text-justify: inter-word;
}
</style>