<template>
  <div id="page">
    <v-container class="d-flex flex-column">
      <v-row justify="center">
        <v-col cols="12" md="2" lg="2">
          <search />
        </v-col>
        <v-col cols = "12" md = "10" lg ="10" class="ml-auto mb-5">
          <h3 class="mb-2"> X resultados encontrados </h3>
          <ads /> 
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  components: {
    Ads: () => import("@/components/ads/Ads"),
    Search: () => import("@/components/global/Search"),
  },
};
</script>