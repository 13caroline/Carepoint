<template>
  <v-col justify-centered sm="12" md="12">
    <v-card flat>
      <div>
        <span>Pesquisar</span>
        <v-text-field
          outlined
          flat
          dense
          class="rounded-xl mb-4"
          color="#78C4D4"
          v-model="formValues.search"
          append-icon="mdi-magnify"
        ></v-text-field>
      </div>
      <div>
        <span>Preço</span>
        <v-slider
          v-model="formValues.price"
          inverse-label
          :label="`${form.price} €`"
          color="#78C4D4"
          thumb-label
          :max="`${form.price}`"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Distância</span>
        <v-slider
          v-model="formValues.distance"
          inverse-label
          :label="`${form.distance}km`"
          color="#78C4D4"
          thumb-label
          :max="`${form.distance}`"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Categoria</span>
        <v-autocomplete
          outlined
          flat
          class="rounded-xl"
          dense
          color="#78C4D4"
          :items="form.cat"
          item-value="idCategory"
          item-text="name"
          v-model="formValues.category"
        />
      </div>
      <div>
        <span>Localização</span>
        <v-autocomplete
          outlined
          flat
          class="rounded-xl"
          dense
          color="#78C4D4"
          :items="form.loc"
          item-value="idLocation"
          item-text="name"
          v-model="formValues.location"
        />
      </div>
      <div>
        <span>Classificação </span>
        <v-slider
          v-model="formValues.rating"
          inverse-label
          :label="`${formValues.rating}`"
          color="#78C4D4"
          thumb-label
          :max="`${form.rating}`"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Sexo</span>
        <v-radio-group v-model="formValues.sex" row class="radio">
          <v-radio
            label="Feminino"
            value="F"
            color="#78C4D4"
            class="ml-0"
          ></v-radio>
          <v-radio
            label="Masculino"
            value="M"
            color="#78C4D4"
            class="ml-0"
          ></v-radio>
        </v-radio-group>
      </div>
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
import Vue from 'vue';
export const EventBus = new Vue();
export default {
  name: "Search",

  data() {
    return {
      formValues: {
        search: "",
        category: "",
        distance: 0,
        price: 0,
        rating: 0,
        sex: "",
        location: "",
      },
      form: {
        categories: [
          "Companhia",
          "Compras",
          "Higiene",
          "Medicação",
          "Refeições",
        ],
        distance: 0,
        price: "",
        search: "",
        rating: 0,
        location: "",
        row: null,
        loc: [],
        cat: [],
      },
    };
  },
  methods: {
    searchForm() {
      console.log(this.formValues);
      EventBus.$emit('clicked', this.formValues);
    },
  },
  created: async function () {
    try {
      let response = await axios.get("http://localhost:9040/search/max");
      if (response) {
        this.form.rating = response.data[0].rating;
        this.form.price = response.data[0].price;
        this.form.distance = response.data[0].distance;
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
span {
  color: #797878;
  font-size: small;
}

.radio {
  font-size: 10px;
}

div {
  margin-left: 5%;
  margin-right: 10%;
}
</style>
