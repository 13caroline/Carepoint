<template>
  <v-dialog v-model="dialog" width="50%">
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        class="body-2 mr-2 rounded-xl button"
        small
        color="#78C4D4"
        outlined
        dark
        v-bind="attrs"
        v-on="on"
      >
        Alterar fotografia
        <v-icon small class="ml-2">fas fa-camera</v-icon>
      </v-btn>
    </template>
    <v-card>
      <v-container>
        <v-card-title>Alterar fotografia</v-card-title>
        <v-divider></v-divider>
        <v-card-text>
          <div class="ma-auto">
            <span>Carregar fotografia</span>
            <!--<v-file-input
              append-icon="fas fa-camera"
              v-model="image"
              type="file"
              class="input"
              color="#78C4D4"
              prepend-icon=""
              :rules="rules"
              outlined
              dense
              @change="onFileChange"
            />-->
            <input
                type="file"
                id="file"
                ref="file"
                v-on:change="handleFileUpload()"
                :rules="rules"
              />
          </div>
          <div>
            <span>Preview</span>
            <v-img
              :src="imageUrl"
              style="border: 1px dashed #ccc; min-height: 250px"
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
                :disabled="!file"
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
import store from "@/store/index.js"
export default {
  props: ["id"],
  name: "upload-image",
  data() {
    return {
      dialog: false,
      image: null,
      file: "", 
      imageUrl: "",
      cancelar: { title: "a alteração da sua fotografia", text: "a alteração da sua fotografia" },
      rules: [
      files => !files || !files.some(file => file.size > 102400) || 'Avatar size should be less than 100 KB!'
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
    onFileChange(file) {
      if (!file) {
        return;
      }
      this.createImage(file);
    },
    close() {
        this.imageUrl = "";
        this.image = null;
        this.dialog = false;
    },
     handleFileUpload() {
      this.file = this.$refs.file.files[0];
      this.url = URL.createObjectURL(this.file);
    },
    upload: async function () {
      let formData = new FormData();
      

      formData.append("idUser", this.id);
      formData.append("image", this.file); 

        try {
          let response = await axios.put("http://localhost:9040/users/updatePhoto", {
            formData, 
            token: store.getters.token
          });
          console.log(response);
          this.dialog = false; 

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
</style>