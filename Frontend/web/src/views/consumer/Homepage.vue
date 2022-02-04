<template>
  <div id="page">
    <app-bar />

    <v-container class="d-flex flex-column">
      <v-row justify="center">
        <v-col cols="12" md="3" lg="3">
          <search :tipo="tab"/>
        </v-col>
      <v-col cols="12" md="9" sm="9" class="ml-auto ml-sm-11 ma-md-0 mb-5">
      <v-tabs v-model="tab" grow color="#78C4D4" background-color="#fafafa" show-arrows>
        <v-tab v-for="item in items" :key="item.tab">
          {{ item.tab }}
        </v-tab>
      </v-tabs>

      <v-tabs-items v-model="tab">
        <v-tab-item>
          <view-ads :tipo="tab"></view-ads>
        </v-tab-item>

        <v-tab-item>
          <view-ads :tipo="tab"></view-ads>
        </v-tab-item>
      </v-tabs-items>
      </v-col>
      </v-row>

    </v-container>
    <top-button />
    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {
      tab: null,
      items: [
        { tab: "Prestadores Individuais" },
        { tab: "Prestadores Coletivos" },
      ],
      user: {},
      categories: {},
    };
  },
  components: {
    AppBar: () => import("@/components/global/AppBarAccount"),
    ViewAds: () => import("@/components/ads/ViewAds.vue"),
    TopButton: () => import("@/components/global/TopButton"),
    Search: () => import("@/components/global/Search"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>