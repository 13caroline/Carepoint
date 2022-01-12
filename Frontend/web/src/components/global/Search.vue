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
          label="200€"
          color="#78C4D4"
          thumb-label
          max="200"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Distância</span>
        <v-slider
          v-model="distance"
          inverse-label
          label="12km"
          color="#78C4D4"
          thumb-label
          max="12"
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
          :items="categories"
          v-model="category"
        ></v-select>
      </div>
      <div>
        <span>Classificação </span>
        <v-slider
          v-model="rating"
          inverse-label
          label="10"
          color="#78C4D4"
          thumb-label
          max="10"
          min="0"
        ></v-slider>
      </div>
      <div>
        <span>Sexo</span>
        <v-radio-group v-model="row" row class="radio">
          <v-radio label="Feminino" value="feminino" color="#78C4D4"></v-radio>
          <v-radio label="Masculino" value="masculino" color="#78C4D4"></v-radio>
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
export default {
  name: "Search",

  data() {
    return {
      categories: ["Companhia", "Compras", "Higiene", "Medicação", "Refeições"],
      category: "",
      distance: "",
      price: "",
      search: "",
      rating:0,
      row:null,
    };
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