<template>
  <v-btn
    id="topbutton"
    v-scroll="onScroll"
    depressed
    fixed
    bottom
    right
    color="#78C4D4"
    dark
    fab
    v-show="fab"
    small
    @click="$vuetify.goTo(0)"
  >
    <v-icon>mdi-chevron-up</v-icon>
  </v-btn>
</template>

<script>
export default {
  name: "CoreCta",

  data() {
    return {
        fab: false,
    };
  },
  methods: {
    onScroll(e) {
      if (typeof window === "undefined") return;
      const top = window.pageYOffset || e.target.scrollTop || 0;
      this.fab = top > 20;
    },
  },
};
</script>