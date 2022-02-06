<template>
  <v-col justify-centered cols="12" sm="12" md="12">
    <v-card flat>
      <div class="mx-sm-16 mx-md-0 mx-5 mx-lg-0 mx-xl-0">
        <p class="mt-6 mb-0 font-weight-bold">Pesquisar</p>
        <v-text-field
          outlined
          flat
          dense
          color="#78C4D4"
          v-model="formValues.search"
          append-icon="mdi-magnify"
        ></v-text-field>
      </div>
      <div class="mx-sm-16 mx-md-0 mx-5 mx-lg-0 mx-xl-0">
        <h4>Filtrar por:</h4>
      </div>

      <v-card class="mx-sm-16 mx-md-0 mx-5 mx-lg-0 mx-xl-0" outlined>
        <v-list-item>
          <v-list-item-content>
            <div>
              <p class="mt-2 mb-0 font-weight-bold">Preço</p>
              <v-slider
                v-model="formValues.price"
                inverse-label
                :label="`${form.price} €/hora`"
                color="#78C4D4"
                thumb-label
                :max="`${form.price}`"
                min="0"
              ></v-slider>
            </div>
            <div>
              <p class="mb-0 font-weight-bold">Experiência</p>
              <v-slider
                v-model="formValues.experience"
                inverse-label
                :label="`${form.experience} anos`"
                color="#78C4D4"
                thumb-label
                :max="`${form.experience}`"
                min="0"
              ></v-slider>
            </div>
            <div>
              <p class="mb-0 font-weight-bold">Classificação</p>
              <v-slider
                v-model="formValues.rating"
                inverse-label
                :label="`${form.rating}`"
                color="#78C4D4"
                thumb-label
                :max="`${form.rating}`"
                min="0"
              ></v-slider>
            </div>
            <div>
              <p class="mb-0 font-weight-bold">Localização</p>
              <v-autocomplete
                outlined
                flat
                dense
                color="#78C4D4"
                :items="form.loc"
                item-value="idLocation"
                item-text="name"
                v-model="formValues.location"
              />
            </div>
          </v-list-item-content>
        </v-list-item>
      </v-card>

      <v-card class="mx-sm-16 mx-md-0 mx-5 mx-lg-0 mx-xl-0 mt-2" outlined>
        <v-list-item>
          <v-list-item-content>
            <div>
              <p class="font-weight-bold">Categoria</p>
              <div v-for="c in form.cat" :key="c.idCategory">
                <v-checkbox
                  v-model="formValues.category"
                  color="#78C4D4"
                  :label="c.name"
                  :value="c.idCategory"
                  class="my-checkbox py-0 my-0"
                ></v-checkbox>
              </div>
            </div>
          </v-list-item-content>
        </v-list-item>
      </v-card>

      <v-card class="mx-sm-16 mx-md-0 mx-5 mx-lg-0 mx-xl-0 mt-2" outlined>
        <v-list-item>
          <v-list-item-content>
            <div>
              <p class="mb-0 font-weight-bold">Sexo</p>
              <v-checkbox
                v-model="formValues.sex"
                label="Feminino"
                value="F"
                color="#78C4D4"
                class="my-checkbox"
              ></v-checkbox>
              <v-checkbox
                v-model="formValues.sex"
                label="Masculino"
                value="M"
                color="#78C4D4"
                class="my-checkbox py-0 my-0"
              ></v-checkbox>
            </div>
          </v-list-item-content>
        </v-list-item>
      </v-card>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
          depressed
          dark
          color="#78c4d4"
          type="submit"
          class="rounded-lg"
          @click="searchForm()"
        >
          Procurar
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-col>
</template>

<script>
import axios from "axios";
import Vue from "vue";
export const EventBus = new Vue();
import adsCmpanySearch from "../ads/AdsCompany.vue";
import ads from "../ads/Ads.vue";
export default {
  name: "Search",
  props: ["tipo"],

  data() {
    return {
      formValues: {
        search: null,
        category: null,
        experience: null,
        price: null,
        rating: null,
        sex: null,
        location: null,
      },
      form: {
        experience: 0,
        price: "",
        search: "",
        rating: 0,
        loc: [],
        cat: [],
      },
    };
  },
  methods: {
    searchForm() {
      console.log(this.formValues);
      console.log("Procura em => ", this.tipo);
      this.tipo == 1
        ? adsCmpanySearch.methods.getData(this.formValues)
        : ads.methods.searchForm(this.formValues);
    },
  },
  created: async function () {
    try {
      let response = await axios.get("http://localhost:9040/search/max");
      console.log(response.data);
      if (response) {
        this.form.rating = response.data[0].rating;
        this.form.price = response.data[0].price;
        this.form.experience = response.data[0].experience;
      }
    } catch (e) {
      console.log(e);
    }

    try {
      let response2 = await axios.get("http://localhost:9040/location");
      if (response2) {
        this.form.loc = response2.data;
      }
    } catch (e) {
      console.log(e);
    }

    try {
      let response3 = await axios.get("http://localhost:9040/category");
      if (response3) {
        this.form.cat = response3.data;
      }
    } catch (e) {
      console.log(e);
    }
  },
};
</script>

<style scoped>
p {
  color: #797878;
  font-size: small;
}

h4 {
  color: #707978;
}

::v-deep .my-checkbox .v-label {
  font-size: 15px;
}
</style>
