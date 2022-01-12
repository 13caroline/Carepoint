<template>
  <div id="page">
    <v-container class="d-flex flex-column">
      <v-row justify="center">
        <v-col cols="12" md="3" lg="3">
          <search />
        </v-col>
        <v-col cols = "12" md = "9" lg ="9" class="ml-auto mb-5">
          <ads /> 
        </v-col>
      </v-row>
      <top-button/>
    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
    };
  },
  components: {
    Ads: () => import("@/components/ads/Ads"),
    Search: () => import("@/components/global/Search"),
    TopButton: () => import("@/components/global/TopButton")
  },

};
</script>