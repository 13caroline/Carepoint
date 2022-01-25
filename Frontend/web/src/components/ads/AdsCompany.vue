<template>
  <v-container>
    <v-data-iterator
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
                height="300"
                width="500"
                @click="infoSP(a.idUser)"
              >
                <v-card-text>
                  <v-row justify="center">
                    <v-col cols="auto">
                      <v-avatar class="profile" color="grey" size="100">
                        <v-img :src="processImage(a.image.data)"></v-img>
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
                      <v-clamp autoresize :max-lines="4">{{
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
    <!--<small v-else> <em> não existem anúncios publicados </em></small>-->

    <v-row class="mt-4" align="center" justify="center">
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

    <v-row class="mt-5" align="center" justify="center">
      <span class="grey--text">Página {{ page }} de {{ numberOfPages }}</span>
    </v-row>
  </v-container>
</template>

<script>
import axios from "axios";
import moment from "moment";
import VClamp from "vue-clamp";

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
    VClamp,
  },
  methods: {
    
    difDate(dateLA) {
      return moment(dateLA).locale("pt").fromNow();
    },
    processImage(img) {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(img)))
      );
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
    getData: async function (form) {
      try {
        let url = "http://localhost:9040/search/?page=";
          // console.log('fomr => ',form);
          this.ads = [];
        if(form) {
          this.page = 1;
          // console.log('ads => ',this.ads);
         url = url + this.page +
         (form.category ? "&category=".concat(form.category) : "") + 
         (form.location ? "&location=".concat(form.location) : "") + 
         (form.price ? "&price=".concat(form.price) : "") + 
         (form.rating ? "&rating=".concat(form.rating) : "") + 
         (form.sex ? "&sex=".concat(form.sex) : "");

        }
         else url = url + this.page;
        console.log(url);
        let response = await axios.get(url);


        if (response) {
          console.log(response.data);
          this.ads = response.data.Companies;
          this.total = response.data.Companies_Sum[0].number_companies;
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
