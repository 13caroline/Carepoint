<template>
  <div style="min-height: 100vh">
    <v-app-bar absolute color="#FFFFFF" height="180" flat>
      <v-container>
        <v-layout row>
          <v-col class="d-flex justify-space-around">
            <v-img
              align-center
              center
              src="@/assets/logo.png"
              max-height="220"
              max-width="220"
              @click="$vuetify.goTo(0)"
            >
            </v-img>
          </v-col>
        </v-layout>
        <v-layout row>
          <v-col class="d-flex justify-center">
            <v-divider vertical></v-divider>
            <v-btn
              v-for="(link, i) in links"
              :key="i"
              v-bind="link"
              class="hidden-sm-and-down"
              text
              color="black"
              @click="onClick($event, link)"
            >
              {{ link.text }}
            </v-btn>

            <v-divider vertical></v-divider>
          </v-col>
        </v-layout>
      </v-container>
    </v-app-bar>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "mainpage",
  data() {
    return {};
  },

  computed: {
    ...mapGetters(["links"]),
  },

  methods: {
    onClick(e, item) {
      e.stopPropagation();

      if (item.to || !item.href) return;

      this.$vuetify.goTo(item.href.endsWith("!") ? 0 : item.href);
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Old+Standard+TT:ital,wght@0,400;0,700;1,400&display=swap");
.tab {
  font-family: "Old Standard TT", serif;
  margin: 0 5px;
  font-size: 20px;
}
</style>