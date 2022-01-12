<template>
  <div>
    <v-app-bar flat color="#FFFFFF" height="180">
      <v-container>
        <v-layout row>
          <v-col cols="9" md="6" sm="6" offset-md="4" offset-sm="3" offset="0" class="d-flex justify-center-around">
            <v-img
              id="logo_"
              align-center
              center
              src="@/assets/logo.png"
              max-height="220"
              max-width="220"
              @click="$vuetify.goTo(0)"
            >
            </v-img>
          </v-col>
          <v-col cols="2" md="2" sm="2">
            <v-menu id="menu" bottom left>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  text
                  v-bind="attrs"
                  v-on="on"
                  color="#78C4D4"
                  class="rounded-xl hidden-sm-and-up mt-4"
                >
                  <v-icon>fas fa-bars</v-icon>
                </v-btn>
              </template>
              <v-list dense nav>
                <v-list-item
                  v-for="(link, i) in links"
                  :key="i"
                  @click="onClick($event, link)"
                >
                <!-- Tentei colocar a string dos icons em index.js, mas depois desformata a posição dos items na row quando o tamanho
                do ecrã é superior a xs.. 
                  <v-list-item-icon>
                    <v-icon v-text="link.icon" small color="#78C4D4"></v-icon>
                  </v-list-item-icon>
                -->
                  <v-list-item-content>
                    <v-list-item-title v-text="link.text"></v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
        </v-layout>
        <v-layout row>
          <v-col class="d-flex justify-center">
            <v-divider vertical></v-divider>
            <v-btn
              v-for="(link, i) in links"
              :key="i"
              v-bind="link"
              class="hidden-xs-only"
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
<style>
#menu {
  position:relative;
  top: 0px; 
  right: 50px;
}
#logo_ {
  position:relative;
  top: 0px; 
  left: 50px;
}
</style>