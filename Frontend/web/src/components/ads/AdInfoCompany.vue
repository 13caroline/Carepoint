<template>
  <v-container>
    <v-row class="w-100" align="start">
      <v-col cols="4" md="2">
        <div class="foto h-100">
          <v-img
            :src="processImage(company.image)"
            aspect-ratio="1"
            class="grey lighten-2 rounded"
            cover
          >
            <template v-slot:placeholder>
              <v-row class="fill-height ma-0" align="center" justify="center">
                <v-progress-circular
                  indeterminate
                  color="grey lighten-5"
                ></v-progress-circular>
              </v-row>
            </template>
          </v-img>
        </div>
      </v-col>

      <v-col cols="6" md="6" sm="6" class="ml-13 ml-md-16 ml-sm-0">
        <div>
          <span class="infos font-weight-bold headline">
            {{ company.name }}
          </span>
            
          <p class="infos font-weight-light">
            {{ company.firm }}
          </p>
        </div>

        <div>
          <p class="infos font-weight-bold">
            {{ company.locationName }}
          </p>
        </div>

        <v-btn
            rounded
            outlined 
            color="#78c4d4"
            small
            :href="company.link"
        >
            Site da Empresa
        </v-btn>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <p class="infos font-weight-bold mb-3">Descrição</p>
        <div>
          <p class="desc mt-3">
            {{ company.description }}
          </p>
        </div>
      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col cols="12" sm="3" md="2">
        <div class="infos font-weight-bold">Contactos</div>
        <div class="infos" v-if="company.phoneNumber === 'null'">
          Sem dados de contacto
        </div>
        <div class="infos">{{ company.phoneNumber }}</div>
        <div class="infos">{{ company.email }}</div>
      </v-col>
    </v-row>

    
  </v-container>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  name: "Ads",
  props: ["id"],
  data() {
    return {
      styleObject: { border: "1px solid #78c4d4" },
      company: [],
    };
  },
  methods: {
    formatDate(d) {
      return moment(d, moment.ISO_8601)
        .locale("pt")
        .format("DD MMMM YYYY, HH:MM:SS");
    },
    processImage(img) {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(img.data)))
      );
    },
  },
  created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/company/specific/?id=" + this.id
      );
      this.company = response.data[0];
    } catch (e) {
      this.$snackbar.showMessage({
        show: true,
        color: "error",
        text: "Ocorreu um erro. Por favor tente mais tarde!",
        timeout: 4000,
      });
    }
  },
};
</script>

<style scoped>
.infos {
  color: #797878;
  text-align: justify;
  text-justify: inter-word;
}
.desc {
  color: #c4c4c4;
  text-align: justify;
  text-justify: inter-word;
}
.foto {
  width: 170px;
}

.reviews {
  align-content: center;
}
</style>