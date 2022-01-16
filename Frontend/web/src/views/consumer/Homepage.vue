<template>
  <div id="page">
    <app-bar />

    <v-container>
      <v-tabs v-model="tab" grow color="#2596be" background-color="#fafafa">
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
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>