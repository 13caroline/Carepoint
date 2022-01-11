<template>
  <div>
    <Bar />
    <v-container>
      <v-row>
        <v-col cols="auto" class="ml-auto">
          <v-btn
            class="body-2 rounded-xl button"
            small
            color="#78C4D4"
            outlined
            dark
            to="/consumer/post/ad"
          >
            Publicar anúncio
            <v-icon small class="ml-2">fas fa-plus</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <v-row>
        <v-col
          cols="auto"
          lg="6"
          md="6"
          class="mx-auto mx-sm-0"
          v-for="(a, index) in ads"
          :key="index"
        >
          <v-card class="h-100 mt-5" outlined>
            <v-card-text>
              <v-row>
                <v-col class="pb-0" align="right" cols="">
                  <span class="text-uppercase">Data</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong> {{ a.beginDate }} - {{ a.endDate }} </strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Categoria</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong> Catcat </strong>
                  </span>
                  <br />
                  <span> Apoio a idosos </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Localização</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ a.locationName }}</strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Valor</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ a.price }} €/hora</strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">estado</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <v-chip :color="estado(a.done)" small>
                    {{ getState(a.done) }}
                  </v-chip>
                </v-col>
              </v-row>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>

              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn icon @click="conclude(a.idJobOffer)" :disabled="a.done==1">
                    <v-icon color="#66BB6A" dark v-bind="attrs" v-on="on">
                      mdi-calendar-check
                    </v-icon>
                  </v-btn>
                </template>
                <span>Concluir</span>
              </v-tooltip>

              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn v-bind="attrs" v-on="on" icon @click="show = !show">
                    <v-icon>{{
                      show ? "mdi-chevron-up" : "mdi-chevron-down"
                    }}</v-icon>
                  </v-btn>
                </template>
                <span>Ver descrição</span>
              </v-tooltip>
            </v-card-actions>
            <v-expand-transition>
              <div v-show="show">
                <v-divider></v-divider>

                <v-card-text>
                  {{ a.description }}
                </v-card-text>
              </div>
            </v-expand-transition>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  data() {
    return {
      show: false,
      ads: [],
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
  },

  methods: {
     getState(done){
       if(done==1) return "Não ativo"
       else return "Ativo"
     },
    estado(item) {
      if (item == 0 ) return "#C5E1A5";
      else return "#EF9A9A";
    },
    update: async function () {
      this.ads = [];
      try {
        let response = await axios.post("http://localhost:9040/joboffer/own", {
          token: store.getters.token,
        });
        console.log(response.data);
        this.ads = response.data;
      } catch (e) {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Ocorreu um erro. Por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
    conclude: async function (id) {
      try {
        await axios.put(
          "http://localhost:9040/joboffer/conclude",
          {
            token: store.getters.token,
            id_job_offer: id,
          }
         
        );
         this.update();
      } catch (e) {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Ocorreu um erro. Por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
  },
  created: async function () {
    this.update();
  },
};
</script>