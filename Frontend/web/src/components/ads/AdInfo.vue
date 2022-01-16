<template>
  <v-container>
    <v-row class="w-100" align="start">
      <v-col cols="5" md="2">
        <div class="foto h-100">
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
      </v-col>

      <v-col cols="7" md="10">
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

            <span class="font-weight-bold ml-2" v-if="a.experience == 0">
              {{ noExp }}
            </span>
            <span class="font-weight-bold ml-2" v-else>
              {{ a.experience }} anos
            </span>
          </v-col>
        </v-row><!-- descricao da ad do prestador
        <div>
          <p class="desc mt-3">
            {{ serviceProviderData.description }}
          </p>
        </div>
        <v-divider></v-divider>-->
      </v-col> 
    </v-row>

    <v-row>
      <v-col>
        <p class="infos font-weight-bold mb-3">Descrição</p>
        <div>
          <p class="desc mt-3">
            {{ serviceProviderData.description }}
          </p>
        </div>

      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col cols="12" md="2">
        <div class="infos font-weight-bold">Contactos</div>
        <div class="infos" v-if="serviceProviderData.phoneNumber === 'null'">
          Sem dados de contacto
        </div>
        <div class="infos">{{ serviceProviderData.phoneNumber }}</div>
        <div class="infos">{{ serviceProviderData.email }}</div>
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
      <v-col cols="12" md="2" sm>
        <p class="infos font-weight-bold">Classificação global</p>
        <div>
          <v-icon color="#FFE082" class="mb-1" small>fas fa-star</v-icon>
          <span class="font-weight-bold ma-2">{{
            serviceProviderData.averageRating
          }}</span>
        </div>
      </v-col>
      <v-col cols="12" md="10" sm>
        <p class="infos font-weight-bold">Horário</p>
        <schedule v-if="serviceProvider" :dados="serviceProvider.categories"/>
      </v-col>
    </v-row>

    <v-row class="w-100" align="start">
      <v-col cols="12" md="3" sm>
        <span class="infos font-weight-bold">Comentários</span>
        <span class="grey--text text--lighten-2 text-caption mr-2">
          ({{ reviews }})
        </span>
      </v-col>

      <v-col cols="12" md="9" sm class="d-flex justify-end">
        <add-review :dados="id" />
      </v-col>
    </v-row>

    <v-data-iterator
      v-if="reviews"
      :items="serviceProvider.reviews"
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
                <v-col cols="12" md="10" sm="10" xs="8">
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
                <v-col cols="12" md="2" sm="2" xs="4">
                  <div class="font-weight-bold ratings">
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

    <v-row class="mt-4" align="center" justify="center" v-if="reviews">
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

    <v-row class="mt-5" align="center" justify="center" v-if="reviews">
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
      image: "",
      sortDesc: false,
      pageCount: 0,
      page: 1,
      itemsPerPage: 6,
      reviews: 0,
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
      serviceProvider: {},
    };
  },
  methods: {
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
    updateItemsPerPage(number) {
      this.itemsPerPage = number;
    },
  },
  components: {
    Schedule: () => import("@/components/ads/Schedule"),
    AddReview: () => import("@/components/dialogs/AddReview"),
  },
  computed: {
    numberOfPages() {
      return Math.ceil(this.reviews / this.itemsPerPage);
    },
  },
  created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/serviceProvider/?id=" + this.id
      );
      (this.serviceProviderData = response.data.ServiceProvider[0]);
      (this.serviceProvider = response.data);
      this.reviews = response.data.reviews.length;
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