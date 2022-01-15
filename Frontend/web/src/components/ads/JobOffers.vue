<template>
  <v-container>
    <v-data-iterator
      v-if="ads"
      :items="ads"
      :items-per-page.sync="itemsPerPage"
      :page.sync="page"
      :sort-desc="sortDesc"
      hide-default-footer
      @page-count="pageCount == $event"
      no-data-text="Não existem anúncios publicados."
      no-results-text="Não foram encontrados resultados."
    >
      <template v-slot:default="props">
        <v-row>
          <v-col
            cols="auto"
            lg="4"
            md="4"
            class="mx-auto mx-sm-0"
            v-for="(a, index) in props.items"
            :key="index"
          >
            <div class="user">
              <v-card
                class="card rounded-xl overflow-auto"
                color="#c0e4ec"
                tile
                height="400"
                width="500"
                @click="infoSP(a.idUser)"
              >
                <v-card-text>
                  <v-row>
                    <v-col cols="12" md="4" sm="2">
                      <span class="activity d-flex justify-start pb-2" >
                      {{convertDate(a.postDate)}}
                      </span
                      >
                    </v-col>
                    <v-col cols="12" md="8" sm="10">
                      <span class="activity d-flex justify-end"
                        >última vez ativo {{ difDate(a.lastActivity) }}</span
                      >
                    </v-col>
                  </v-row>

                  <v-row justify="center" class="mx-auto">
                    <span class="indication font-weight-bold">
                      {{ a.name }}
                    </span>
                  </v-row>

                  <v-row>
                <v-col class="pb-0" align="right" cols="">
                  <span class="text-uppercase">Data</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong> {{ a.beginDate }} até {{ a.endDate }} </strong>
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



                  <v-divider class="mx-4 mt-5"></v-divider>

                  <v-row justify="center" class="mx-auto">
                    <span class="description">
                      <v-clamp autoresize :max-lines="4">{{a.description}}</v-clamp>
                      
                    </span>
                  </v-row>
                </v-card-text>
              </v-card>
            </div>
          </v-col>
        </v-row>
      </template>
    </v-data-iterator>
    <small v-else> <em> não existem anúncios publicados </em></small>

    <v-row class="mt-4" align="center" justify="center" v-if="ads">
      <v-btn
        fab
        dark
        small
        depressed
        color="#78C4D4"
        class="mr-1"
        @click="formerPage"
      >
        <v-icon>mdi-chevron-left</v-icon>
      </v-btn>
      <v-btn
        fab
        dark
        small
        depressed
        color="#78C4D4"
        class="ml-1"
        @click="nextPage"
      >
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
    </v-row>

    <v-row class="mt-5" align="center" justify="center" v-if="ads">
      <span class="grey--text">Página {{ page }} de {{ numberOfPages }}</span>
    </v-row>
  </v-container>
</template>

<script>
import axios from "axios";
import moment from "moment";
import VClamp from 'vue-clamp'
export default {
  name: "Ads",

  data() {
    return {
      image: "",
      styleObject: { border: "1px solid #78C4D4" },
      ads: [],
      sortDesc: false,
      pageCount: 0,
      page: 1,
      itemsPerPage: 9,
      total: 0,
    };
  },
  components: {
    VClamp
  },
  methods: {
    difDate(dateLA) {
      return moment(dateLA).locale("pt").fromNow();
    },
    processImage(img) {
      return "data:image/jpeg;base64," + btoa(img);
    },
    infoSP(id) {
      this.$router.push("/ad/info/" + id);
    },
    nextPage() {
      if (this.page + 1 <= this.numberOfPages) this.page += 1;
      this.getData();
    },
    formerPage() {
      if (this.page - 1 >= 1) this.page -= 1;
      this.getData();
    },
    convertDate(d){
           return moment(d , moment.ISO_8601).format("DD-MM-YYYY")
        },
    getData: async function () {
      try {
        let response = await axios.get("http://localhost:9040/joboffer/?page=" + this.page);
        if (response) {
            console.log(response.data)
          this.ads = response.data.JobOffers;
          this.total = response.data.Total[0].number_offers;
          /*this.ads = response.data.ServiceProviders.map(an => {
      an.image = an.image ? "data:image/jpeg;charset=utf-8;base64," + an.image : require("@/assets/userTest.png")
         })*/
        }
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
  computed: {
    numberOfPages() {
      return Math.ceil(this.total / this.itemsPerPage);
    },
  },

  created: async function () {
    this.getData();
  },
};
</script>

<style scoped>
.user {
  width: 100%;
}

.round {
  border-radius: 100%;
}

.indication {
  text-align: center;
}

.description {
  text-align: justify;
  text-justify: auto;
  color: grey;
  margin-top: 2em;
}

.activity {
  font-size: smaller;
  text-align-last: right;
}
</style>