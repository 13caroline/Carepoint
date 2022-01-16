<template>
  <v-dialog v-model="dialog" width="auto">
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
            <v-file-input
              append-icon="fas fa-camera"
              v-model="image"
              type="file"
              class="input"
              color="#78C4D4"
              prepend-icon=""
              outlined
              dense
              @change="onFileChange"
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
                :disabled="!image"
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
export default {
  name: "upload-image",
  data() {
    return {
      dialog: false,
      image: null,
      imageUrl: "",
        cancelar: { title: "a alteração da sua fotografia", text: "a alteração da sua fotografia" },

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
  },
};
</script>

<style scoped>
</style>