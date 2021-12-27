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
      <v-card-title>Alterar fotografia</v-card-title>
      <v-divider></v-divider>
      <v-card-text>
        <v-row class="ma-auto">
          <v-col>
            <span>Carregar fotografia</span>
            <v-file-input
              append-icon="mdi-camera"
              v-model="image"
              type="file"
              class="input"
              outlined
              dense
              @change="onFileChange"
            />
          </v-col>
        </v-row>
        <v-col>
          <h4>Preview</h4>
          <v-img
            :src="imageUrl"
            style="border: 1px dashed #ccc; min-height: 250px"
          />
        </v-col>
      </v-card-text>
      <v-divider></v-divider>
      <v-card-actions>
        <v-btn color="blue darken-1" text @click="dialog = false">
          Close
        </v-btn>
        <v-btn color="blue darken-1" text @click="dialog = false"> Save </v-btn>
      </v-card-actions>
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
    };
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
  },
};
</script>

<style scoped>
</style>