<template>
  <v-card flat>
    <div>
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
        label="200€"
        color="#78C4D4"
        thumb-label
        max="12km"
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
  </v-card>
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
</style>