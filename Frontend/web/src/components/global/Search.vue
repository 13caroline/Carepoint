<template>
  <v-col justify-centered sm="12" md="12">
    <v-card flat>
      <div id="pesquisa">
        <span>Pesquisar</span>
        <v-text-field
          outlined
          flat
          dense
          class="rounded-xl"
          color="#78C4D4"
          v-model="search"
          append-icon="mdi-magnify"
        ></v-text-field>
      </div>
      <div id="preco">
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
      <div id="distancia">
        <span>Distância</span>
        <v-slider
          v-model="distance"
          inverse-label
          label="12km"
          color="#78C4D4"
          thumb-label
          max="12km"
          min="0"
        ></v-slider>
      </div>
      <div id="categoria">
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
    };
  },
};
</script>


<style scoped>
span {
  color: #797878;
  font-size: small;
}
div {
  margin-left: 5%;
  margin-right: 10%;
  
}

</style>

<!-- 
In line styling:
style="background-color:black"

para colocar os botoes mais pequenos usra o hidden, e adaptar a margin


-->