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
          v-model="search"
          append-icon="mdi-magnify"
        ></v-text-field>
      </div>
      <div>
        <span>Preço</span>
        <v-slider
          v-model="price"
          inverse-label
          :label="`${fields.price} €`"
          color="#78C4D4"
          thumb-label
          :max="fields.price"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Distância</span>
        <v-slider
          v-model="distance"
          inverse-label
          :label="`${fields.distance}km`"
          color="#78C4D4"
          thumb-label
          :max="fields.distance"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Categoria</span>
        <v-select
          outlined
          flat
          class="rounded-xl"
          dense
          color="#78C4D4"
          :items="cat"
          item-value="idCategory"
          item-text="name"
          v-model="category"
        ></v-select>
      </div>
      <div>
        <span>Localização</span>
        <v-select
          outlined
          flat
          class="rounded-xl"
          dense
          color="#78C4D4"
          :items="loc"
          item-value="idLocation"
          item-text="name"
          v-model="location"
        ></v-select>
      </div>
      <div>
        <span>Classificação </span>
        <v-slider
          v-model="rating"
          inverse-label
          :label="`${fields.rating}`"
          color="#78C4D4"
          thumb-label
          :max="fields.rating"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Sexo</span>
        <v-radio-group v-model="row" row class="radio">
          <v-radio
            label="Feminino"
            value="feminino"
            color="#78C4D4"
            class="ml-0"
          ></v-radio>
          <v-radio
            label="Masculino"
            value="masculino"
            color="#78C4D4 "
            class="ml-0"
          ></v-radio>
        </v-radio-group>
      </div>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn depressed dark color="#78c4d4" type="submit" class="rounded-lg">
          Procurar
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-col>
</template>

<script>
import axios from "axios";
export default {
  name: "Search",

  data() {
    return {
      fields: {
        price: 0,
        distance: 0,
        rating: 0,
      },
      categories: ["Companhia", "Compras", "Higiene", "Medicação", "Refeições"],
      category: "",
      distance: "",
      price: "",
      search: "",
      rating: 0,
      location: "",
      row: null,
      loc: [],
      cat: [],
    };
  },
  created: async function () {
    try {
      let response = await axios.get("http://localhost:9040/search/max");
      if (response) {
        this.fields.rating = response.data[0].rating;
        this.fields.price = response.data[0].price;
        this.fields.distance = response.data[0].distance;
      }
    } catch (e) {
      console.log(e);
    }

    try {
      let response2 = await axios.get("http://localhost:9040/location");
      if (response2) {
        this.loc = response2.data;
      }
    } catch (e) {
      console.log(e);
    }

    try {
      let response3 = await axios.get("http://localhost:9040/category");
      if (response3) {
        this.cat = response3.data;
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