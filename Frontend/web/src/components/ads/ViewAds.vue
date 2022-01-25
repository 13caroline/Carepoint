<template>
  <div id="page">
    <v-container class="d-flex flex-column">
      <v-row justify="center">
        <!--<v-col cols="12" md="3" lg="3">
          <search />
        </v-col>-->
       <v-col cols="12" sm= "12" md = "12" lg ="12" class="ml-auto ml-sm-11 ma-md-0 mb-5">
          <div v-if="tipo == 0">
            <ads />
          </div>
          <div v-else-if="tipo == 1">
            <compAds />
          </div>
          <div v-else>
            <job-offers/>
          </div>
      </v-col>
      </v-row>
      <top-button />
    </v-container>
  </div>
</template>

<script>

export default {
  props: ["tipo"],
  data() {
    return {};
  },

  components: {
    compAds: () => import("@/components/ads/AdsCompany"),
    Ads: () => import("@/components/ads/Ads"),
    JobOffers: () => import("@/components/ads/JobOffers"),
    // Search: () => import("@/components/global/Search"),
    TopButton: () => import("@/components/global/TopButton"),
  },
};

</script>
