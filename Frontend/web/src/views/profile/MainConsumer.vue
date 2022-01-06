<template>
  <div id="page">
    <app-bar />
    <v-container class="d-flex flex-column">
      <v-row justify="center">
        <v-col cols="12" md="3" lg="3">
          <search />
        </v-col>
        <v-col lg="8" class="ml-auto mb-5">
          <ads />
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
    return {};
  },
  components: {
    AppBar: () => import("@/components/global/AppBarAccount"),
    Ads: () => import("@/components/global/Ads"),
    Search: () => import("@/components/global/Search"),
    TopButton: () => import("@/components/global/TopButton"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>