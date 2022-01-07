<template>
  <v-container>
    <v-row class="w-100" align="start">
      <v-col cols="12" md="2">
        <div class="foto h-100 mt-5">
          <v-img
            :src="image"
            aspect-ratio="1"
            class="grey lighten-2 mx-2 rounded"
            cover
          >
            <!--<template v-slot:placeholder>
              <v-row class="fill-height ma-0" align="center" justify="center">
                <v-progress-circular
                  indeterminate
                  color="grey lighten-5"
                ></v-progress-circular>
              </v-row>
            </template>-->
          </v-img>
        </div>

        <div class="infos font-weight-bold mt-6">Contactos</div>
        <div class="infos" v-if="serviceProviderData.phoneNumber === 'null'">
          Sem dados de contacto
        </div>
        <div class="infos">{{ serviceProviderData.phoneNumber }}</div>
        <div class="infos">{{ serviceProviderData.email }}</div>
      </v-col>

      <v-col cols="12" md="10" sm>
        <div>
          <p class="infos font-weight-bold headline">
            {{ serviceProviderData.name }}
          </p>
        </div>
        <p class="infos font-weight-bold mb-3">Anos de experiência</p>
        <v-row>
          <v-col
            cols="12"
            md="2"
            v-for="(a, index) in serviceProvider.categories"
            :key="index"
          >
            <v-tooltip top color="#78C4D4">
              <template v-slot:activator="{ on, attrs }">
                <v-btn icon outlined color="#78C4D4" v-bind="attrs" v-on="on">
                  <v-icon color="#78C4D4" small>{{ getIcon(a.name) }}</v-icon>
                </v-btn>
              </template>
              <span>{{ a.name }}</span>
            </v-tooltip>

            <span class="font-weight-bold ml-2">{{ a.experience }} anos</span>
          </v-col>
        </v-row>
        <div>
          <p class="desc mt-3">
            {{ serviceProviderData.description }}
          </p>
          <v-divider></v-divider>
        </div>
      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col cols="12" md="2">
        <span class="infos font-weight-bold">Classificação global</span>
        <div class="mt-4"><span class="classification">9.1</span> /10</div>
      </v-col>

      <v-col cols="12" md="10" sm>
        <span class="infos font-weight-bold">Serviços</span>
        <div class="mt-4">
          <v-chip-group active-class="primary--text" column>
            <v-chip
              v-for="(c, index) in serviceProvider.categories"
              :key="index"
              outlined
              color="#78C4D4"
              label
            >
              {{ c.name }}
            </v-chip>
          </v-chip-group>
        </div>
      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col cols="12" md="12" sm>
        <p class="infos font-weight-bold">Horário</p>
        <!-- <VueSchedule
          v-model="schedule"
          bg="white"
            bgHover="gray"
            bgActive="#c0e4ec"
        />-->
      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col cols="12" md="12" sm>
        <span class="infos font-weight-bold">Comentários</span>
      </v-col>

      <div
        class="w-100 ma-0"
        v-for="(a, index) in serviceProvider.reviews"
        :key="index"
      >
        <v-card
          class="card pa-5 rounded-xl overflow-auto mt-2"
          outlined
          tile
          :style="styleObject"
          width="100%"
          to="/ad/info"
        >
          <v-row align="center">
            <v-col cols="12" md="11" sm="11">
              <div>
                <span class="font-weight-bold">{{
                  formatDate(a.postDate)
                }}</span>
              </div>
              <div justify="center" class="mx-auto">
                <span class="infos">
                  {{ a.description }}
                </span>
              </div>
            </v-col>
            <v-col cols="12" md="1" sm="1">
              <span class="classification">{{ a.rating }}</span> /10
            </v-col>
          </v-row>
        </v-card>
      </div>
    </v-row>
  </v-container>
</template>

<script>
import "vue-daily-scheduler/dist/vue-schedule.min.css";
//import VueSchedule from "vue-daily-scheduler";
import axios from "axios";
import moment from "moment";

export default {
  name: "Ads",
  props: ["id"],
  data() {
    return {
      image: "",
      styleObject: { border: "1px solid #78c4d4" },
      category: [
        { name: "Companhia", icon: "fas fa-user-friends" },
        { name: "Compras", icon: "fas fa-shopping-cart" },
        { name: "Medicação", icon: "fas fa-tablets" },
        { name: "Higiene", icon: "fas fa-pump-medical" },
        { name: "Passeios", icon: "fas fa-walking" },
        { name: "Refeições", icon: "fas fa-utensils" },
      ],
      serviceProviderData: {},
      serviceProvider: {
        reviews: [
          {
            postDate: "12/12/2020",
            description:
              "Isto é uma review da pessoa. Muito agradavel, fez tudo o pedido e por um preço acessível, recomendo 100%",
            rating: 9.5,
          },
        ],
      },
    };
  },
  methods: {
    formatDate(d) {
      return moment(d, moment.ISO_8601)
        .locale("pt")
        .format("MMMM Do YYYY, h:mm:ss a");
    },
    getIcon(c) {
      var row = this.category.filter((obj) => {
        return obj.name === c;
      });
      return Object.values(row[0])[1];
    },
  },
  components: {
    // VueSchedule,
  },

  created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/serviceProvider/?id=" + this.id
      );
      console.log(response.data);
      (this.serviceProviderData = response.data.ServiceProvider[0]),
        (this.serviceProvider = response.data);
      this.image =
        "data:image/jpeg;base64," + btoa(this.serviceProviderData.image.data);
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
}
.desc {
  color: #c4c4c4;
  text-align: justify;
  text-justify: inter-word;
}
.foto {
  width: 170px;
}
.classification {
  border-radius: 50%;
  width: 34px;
  height: 34px;
  padding: 10px;
  background: #fff;
  border: 1px solid #78c4d4;
  color: #000;
  text-align: center;
  font: 20px Arial, sans-serif;
}
</style>