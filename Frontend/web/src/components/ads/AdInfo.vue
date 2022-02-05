<template>
  <v-container>
    <v-row class="w-100" align="start">
      <v-col xs="3" sm="3" md="3" lg="2" xl="2">
        <div class="foto h-100">
          <v-img
            :src="processImage(serviceProviderData.image)"
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

      <v-col xs="9" md="6" sm="6" lg="7" class="">
        <div>
          <p class="infos font-weight-bold headline">
            {{ serviceProviderData.name }}
          </p>
        </div>
        <p class="infos font-weight-bold mb-3">Anos de experiência</p>
        <v-chip class="font-weight-bold" v-if="categories">
          {{ categories[0].experience }} anos</v-chip
        >
        <v-chip v-else class="font-weight-bold">{{ noExp }}</v-chip>
        <div class="mt-2">
          <span class="solidarity" v-if="serviceProviderData.solidarity == 1">
            Aderente ao banco de horas
          </span>
          <v-icon
            small
            color="#AED581"
            v-if="serviceProviderData.solidarity == 1"
            >fas fa-check-circle</v-icon
          >
        </div>
      </v-col>
      <v-col cols="auto" class="ml-lg-5">
        <send-message :dados="id" @clicked="update()" />
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <p class="infos font-weight-bold mb-3">Descrição</p>
        <div>
          <p class="desc mt-3">
            {{ serviceProviderData.description }}
          </p>
        </div>
      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col cols="12" sm="3" md="2" lg="2">
        <div class="infos font-weight-bold">Contactos</div>
        <div class="infos" v-if="serviceProviderData.phoneNumber === 'null'">
          Sem dados de contacto
        </div>
        <div class="infos">{{ serviceProviderData.phoneNumber }}</div>
        <div class="infomail">{{ serviceProviderData.email }}</div>
      </v-col>

      <v-col cols="12" sm="9" md="9" lg="9" class="ml-md-0">
        <span class="infos font-weight-bold">Serviços</span>
        <div class="mt-4">
          <v-chip-group active-class="primary--text" column>
            <v-chip
              v-for="(c, index) in categories"
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
      <v-col cols="12" sm="2" md="2">
        <p class="infos font-weight-bold">Classificação global</p>
        <div>
          <v-icon color="#FFE082" class="mb-1" small>fas fa-star</v-icon>
          <span class="font-weight-bold ma-2">{{
            serviceProviderData.averageRating.toFixed(1)
          }}</span>
        </div>

        <p class="infos font-weight-bold mt-5">Preços praticados</p>
        <div v-for="(c, index) in categories" :key="index">
          <v-tooltip top color="#78C4D4">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                icon
                outlined
                color="#78C4D4"
                v-bind="attrs"
                v-on="on"
                class="my-1"
              >
                <v-icon color="#78C4D4" small>{{ getIcon(c.name) }}</v-icon>
              </v-btn>
            </template>
            <span>{{ c.name }}</span>
          </v-tooltip>
          <span v-if="c.price" class="infos">
            {{ c.price.toFixed(1) }} €/hora</span
          >
          <span v-else class="infos"> Preço negociável</span>
        </div>
      </v-col>
      <v-col cols="12" md="10" sm>
        <p class="infos font-weight-bold">Horário</p>
        <schedule :dados="id" />
      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col xs="9" sm md="3" lg="3" >
        <span class="infos font-weight-bold">Comentários</span>
        <span class="grey--text text--lighten-2 text-caption mr-2">
          ({{ nrReviews }})
        </span>
      </v-col>

      <v-col xs="3" sm md="4" lg="9" class="d-flex justify-end">
        <add-review :dados="id" @clicked="update()" />
      </v-col>
    </v-row>

    <v-data-iterator
      v-if="nrReviews"
      :items="reviews"
      :items-per-page.sync="itemsPerPage"
      :page.sync="page"
      :sort-desc="sortDesc"
      hide-default-footer
      @page-count="pageCount == $event"
      no-data-text="Não foram realizados comentários."
      no-results-text="Não foram encontrados resultados."
    >
      <template v-slot:default="props">
        <v-row>
          <v-col
            class="w-100 ma-0"
            v-for="(a, index) in props.items"
            :key="index"
            cols="12"
            md="6"
          >
            <v-card
              class="pa-5 rounded-xl overflow-auto mt-2"
              outlined
              tile
              :style="styleObject"
              width="100%"
              height="100%"
            >
              <v-row align="center">
                <v-col cols="8" md="10" sm="10">
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
                <v-col cols="3" md="2" sm="2">
                  <div
                    class="
                      font-weight-bold
                      ratings
                      ml-4 ml-md-0
                      vertical-center
                    "
                  >
                    <v-icon color="#FFE082" class="icon mb-1"
                      >fas fa-star</v-icon
                    >
                    <span class="ml-1">{{ a.rating }}</span>
                  </div>
                </v-col>
              </v-row>
            </v-card>
          </v-col>
        </v-row>
      </template>
    </v-data-iterator>
    <small v-else> <em> prestador sem comentários realizados </em></small>

    <v-row class="mt-4" align="center" justify="center" v-if="nrReviews">
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

    <v-row class="mt-5" align="center" justify="center" v-if="nrReviews">
      <span class="grey--text">Página {{ page }} de {{ numberOfPages }}</span>
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
      noExp: "<1 ano",
      sortDesc: false,
      pageCount: 0,
      page: 1,
      itemsPerPage: 6,
      nrReviews: 0,
      styleObject: { border: "1px solid #78c4d4" },
      serviceProviderData: {},
      reviews: {},
      categories: [],
      category: [
        { name: "Apoio externo", icon: "fas fa-car-side" },
        {
          name: "Cuidados de higiene e conforto pessoal",
          icon: "fas fa-pump-medical",
        },
        { name: "Cuidados de lazer", icon: "fas fa-book-open" },
        { name: "Cuidados médicos", icon: "fas fa-pills" },
        { name: "Fornecimento e apoio nas refeições", icon: "fas fa-utensils" },
        { name: "Higiene habitacional", icon: "fas fa-home" },
      ],
    };
  },
  methods: {
    goTo() {
      this.$router.push("/chat");
    },
    formatDate(d) {
      return moment(d, moment.ISO_8601)
        .locale("pt")
        .format("DD MMMM YYYY, HH:MM:SS");
    },
    getIcon(c) {
      var row = this.category.filter((obj) => {
        return obj.name === c;
      });
      return Object.values(row[0])[1];
    },
    nextPage() {
      if (this.page + 1 <= this.numberOfPages) this.page += 1;
    },
    formerPage() {
      if (this.page - 1 >= 1) this.page -= 1;
    },
    update: async function () {
      try {
        let response = await axios.get(
          "http://localhost:9040/serviceProvider/?id=" + this.id
        );
        this.serviceProviderData = response.data.ServiceProvider[0];
        this.reviews = response.data.reviews;
        this.nrReviews = response.data.reviews.length;
        this.categories = response.data.categories;
      } catch (e) {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Ocorreu um erro. Por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
    updateItemsPerPage(number) {
      this.itemsPerPage = number;
    },
    processImage(img) {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(img.data)))
      );
    },
  },
  components: {
    Schedule: () => import("@/components/ads/Schedule"),
    AddReview: () => import("@/components/dialogs/AddReview"),
    SendMessage: () => import("@/components/dialogs/SendMessage"),
  },
  computed: {
    numberOfPages() {
      return Math.ceil(this.nrReviews / this.itemsPerPage);
    },
  },
  created: async function () {
    this.update();
  },
};
</script>

<style scoped>
.infos {
  color: #797878;
  text-align: justify;
  text-justify: inter-word;
}
.solidarity {
  color: #78c4d4;
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

.vertical-center {
  margin: 0;
  position: absolute;
  top: 50%;
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
}

.infomail {
  word-wrap: break-word;
  color: #797878;
  text-align: justify;
  text-justify: inter-word;
}
</style>