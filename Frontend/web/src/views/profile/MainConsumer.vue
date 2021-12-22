<template>
  <div id="page">
    <app-bar />
    <v-container class="d-flex flex-column">
      <v-row justify="center">
        <v-col cols="12" lg="3">
          <search />
        </v-col>
        <v-col lg="8" class="ml-auto mb-5">
          <ads />
        </v-col>
      </v-row>
    </v-container>
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
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>