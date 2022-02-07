<template>
  <v-container>
    <v-data-iterator
      v-if="ads.length"
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
            cols="12"
            lg="4"
            md="4"
            sm="6"
            class="mx-auto"
            v-for="(a, index) in props.items"
            :key="index"
          >
            <div class="user">
              <v-card
                id="advertise123"
                class="card rounded-xl overflow-auto"
                color="#c0e4ec"
                tile
                min-height="350"
                max-height="400"
                max-width="600"
                @click="infoSP(a.idUser)"
              >
                <v-card-text>
                  <v-row>
                    <v-col cols="5" md="6" sm="4">
                      <span class="activity d-flex justify-start pb-2"
                        ><v-icon color="warning lighten-1" class="mb-1" small
                          >fas fa-star</v-icon
                        >
                        {{ a.averageRating.toFixed(1) }} ({{
                          a.nr_reviews
                        }})</span
                      >
                    </v-col>
                    <v-col md="6" sm="8" class="text-right">
                      <span class="activity d-flex justify-end"
                        >última vez ativo {{ difDate(a.lastActivity) }}</span
                      >
                    </v-col>
                  </v-row>
                  <v-row justify="center">
                    <v-col cols="auto">
                      <v-avatar class="profile" color="white" size="100">
                        <v-img :src="processImage(a.image)"></v-img>
                      </v-avatar>
                    </v-col>
                  </v-row>

                  <v-row justify="center" class="mx-auto">
                    <span class="indication font-weight-bold">
                      {{ a.name }}
                    </span>
                  </v-row>

                  <v-row justify="center" class="mx-auto">
                    <span class="indication">
                      {{ a.location }}
                    </span>
                  </v-row>

                  <v-divider class="mx-4 mt-5"></v-divider>

                  <v-row justify="center" class="mx-auto">
                    <span class="description">
                      <v-clamp autoresize :max-lines="3">{{
                        a.description
                      }}</v-clamp>
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

    <v-row class="mt-4" align="center" justify="center" v-if="ads.length">
      <v-btn
        fab
        dark
        x-small
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
        x-small
        depressed
        color="#78C4D4"
        class="ml-1"
        @click="nextPage"
      >
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
    </v-row>

    <v-row class="mt-5" align="center" justify="center" v-if="ads.length">
      <span class="grey--text">Página {{ page }} de {{ numberOfPages }}</span>
    </v-row>

    <v-dialog v-model="dialog" persistent width="450">
      <v-card class="pa-2" width="100%" height="100%">
        <v-card-title class="grey--text font-weight-light justify-center mb-2">
          <div class="text-xs-center">

              <v-img
                  id="logo_"
                  mx-auto
                  src="@/assets/logo_up.png"
                  height="100"
                  width="155"
                  class="ml-sm-16 mb-sm-2"
                >
              </v-img>
              <div>
                <p id="encontrou" class="text-center">Foram encontrados,
                <strong> {{ total }} prestadores de serviço individuais!</strong></p>
              </div> 

          </div>
        </v-card-title>
        <v-card-text class="text">
          Para poder aceder aos perfis detalhados,
          <strong> junte-se à comunidade Carepoint! </strong>

          <p class="desc mt-4 mb-0">
            Tudo faremos para que a assistência a si ou o apoio a um seu
            familiar seja um processo tranquilo e adequado. Se não encontrou o
            perfil de cuidador pretendido, anuncie o que necessita e
            procuraremos encontrar a resposta para as suas necessidades.
          </p>
        </v-card-text>
        <v-card-actions>
          <v-btn to="/register/type" block large color="#78C4D4" dark>
            Inscrever-se
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import axios from "axios";
import moment from "moment";
import VClamp from "vue-clamp";
export default {
  name: "Ads",
  props: ["id1", "id2"],
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
      dialog: true,
    };
  },
  components: {
    VClamp,
  },
  methods: {
    difDate(dateLA) {
      return moment(dateLA).locale("pt").fromNow();
    },
    processImage(img) {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(img.data)))
      );
    },
    nextPage() {
      if (this.page + 1 <= this.numberOfPages) this.page += 1;
      this.getData(this.page);
    },
    formerPage() {
      if (this.page - 1 >= 1) this.page -= 1;
      this.getData(this.page);
    },
    getData: async function () {
      try {
        let url = "http://localhost:9040/search/serviceProviders?page=";

        url =
          url +
          this.page +
          (this.id1 ? "&category=".concat(this.id1) : "") +
          (this.id2 ? "&location=".concat(this.id2) : "");

        let response = await axios.get(url);
        if (response) {
          this.ads = Object.assign([], response.data.ServiceProviders);
          this.total = response.data.ServiceProviders_Sum[0].number_sps;
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
    await this.getData(this.page);
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

.desc {
  font-size: small;
  text-align: justify;
  text-justify: inter-word;
  color: grey;
}

.activity {
  font-size: smaller;
  text-align-last: right;
}

.text {
  font-size: 20px;
  text-align: center;
}

#encontrou{

  word-break: break-word;
}

#advertise123::-webkit-scrollbar {
  display: none;
}
</style>

