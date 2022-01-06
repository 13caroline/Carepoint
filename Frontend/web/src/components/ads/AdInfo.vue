<template>
  <v-container>
    <v-row class="w-100" align="start">
      <v-col cols="auto">
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
        <p class="infos font-weight-bold mt-6">Contactos</p>
        <div class="infos">{{ serviceProviderData.phoneNumber }}</div>
        <div class="infos">{{ serviceProviderData.email }}</div>
      </v-col>

      <v-col cols="12" sm>
        <v-card class="h-100 mt-2" flat>
          <v-list-item>
            <v-list-item-content>
              <div>
                <p class="infos font-weight-bold">{{ serviceProviderData.name }}</p>
              </div>
              <p class="infos font-weight-bold">Anos de experiência</p>
              <div
               v-for="(a, index) in serviceProvider.categories"
              :key="index"
              >
              <span>{{a.name}} : {{a.experience}}</span>
                
              </div>
              <div>
                <p class="desc mt-3">
                  {{serviceProviderData.description}}
                </p>
                <v-divider></v-divider>
              </div>
            </v-list-item-content>
          </v-list-item>
        </v-card>
      </v-col>
    </v-row>

    <v-row class="w-100 ma-0">
      <v-col cols="12" md="2" sm="3">
        <span class="infos font-weight-bold">Classificação global</span>
        <div class="mt-4"><span class="classification">9.1</span> /10</div>
      </v-col>

      <v-col cols="12" md="10" sm="9">
        <span class="infos font-weight-bold">Serviços</span>
        <div class="mt-4">
          <v-chip-group active-class="primary--text" column>
            <v-chip
              v-for="(c,index) in serviceProvider.categories"
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

    <v-row class="w-100 ma-0">
      <v-col cols="12" md="4" sm="4">
        
      </v-col>

      <v-col cols="12" md="8" sm="8">
        <p class="infos font-weight-bold">Horário</p>
        <!-- <VueSchedule
          v-model="schedule"
          bg="white"
            bgHover="gray"
            bgActive="#c0e4ec"
        />-->
      </v-col>
    </v-row>

    <v-row
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
            <span class="font-weight-bold">{{formatDate(a.postDate)}}</span>
          </div>
          <div justify="center" class="mx-auto">
            <span class="infos ">
              {{ a.description }}
            </span>
          </div>
        </v-col>
        <v-col cols="12" md="1" sm="1" >
            <span class="classification">{{ a.rating }}</span> /10
        
        </v-col>
        </v-row>
      </v-card>
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
  props:["id"],
  data() {
    return {
      image:'',
      styleObject: { border: "1px solid #78c4d4" },
      category: ["Companhia", "Compras", "Medicação", "Higiene"],
      schedule: {
        0: [],
        1: [],
        2: [],
        3: [],
        4: [],
        5: [],
        6: [],
      },
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
      return moment(d,moment.ISO_8601).locale('pt').format("MMMM Do YYYY, h:mm:ss a");
    },
  },
  components: {
    // VueSchedule,
  },

  created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/serviceProvider/?id="+this.id,
        {
          //id: this.id,
        }
        //{ headers: { Authorization: "Bearer " + store.getters.token } }
      );
      console.log(response)
      this.serviceProviderData = response.data.ServiceProvider[0],
      this.serviceProvider = response.data;
      this.image= 'data:image/jpeg;base64,' + btoa(this.serviceProviderData.image.data);
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