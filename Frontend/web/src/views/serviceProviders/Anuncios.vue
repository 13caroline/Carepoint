<template>
  <div>
    <Bar />
    <v-container>
      <v-row justify="center">
        <v-col cols="12" md="3" lg="3">
          <search />
        </v-col>
        <v-col cols="12" md="9" sm="9" class="ml-auto ml-sm-11 ma-md-0 mb-5">
          <v-tabs
            v-model="tab"
            grow
            color="#2596be"
            background-color="#fafafa"
            show-arrows
          >
            <!--<v-tab v-for="item in items" :key="item.tab">
              {{ item.tab }}
            </v-tab>-->
            <v-tab>Prestadores Individuais</v-tab>
            <v-tab>Prestadores Coletivos</v-tab>
            <v-tab v-if="$store.state.sub !== 0">Ofertas de Trabalho</v-tab>
          </v-tabs>

          <v-tabs-items v-model="tab">
            <v-tab-item>
              <spAds :user="user" :tipo="tab"></spAds>
            </v-tab-item>

            <v-tab-item>
              <spAds :user="user" :tipo="tab"></spAds>
            </v-tab-item>

            <v-tab-item>
              <spAds :user="user" :tipo="tab"></spAds>
            </v-tab-item>
          </v-tabs-items>
        </v-col>
      </v-row>
    </v-container>
    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";

//import moment from "moment";
export default {
  data() {
    return {
      tab: null,
      items: [
        { tab: "Prestadores Individuais" },
        { tab: "Prestadores Coletivos" },
        { tab: "Ofertas de trabalho" },
      ],
      user: {},
      categories: {},
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
    spAds: () => import("@/components/ads/ViewAds.vue"),
    Search: () => import("@/components/global/Search"),
  },

  methods: {
    onPick() {
      this.$refs.fileInput.click();
    },
  },
  created: async function () {
    try {
      let response = await axios.post("http://localhost:9040/users/perfil", {
        token: store.getters.token,
      });

      this.user = response.data.perfil[0];

      this.categories = response.data.categories;
      if (this.user.sex == "M") this.user.sex = "Masculino";
      else if (this.user.sex == "F") this.user.sex = "Feminino";
      else this.user.sex = "Indefinido";
    } catch (e) {
      this.$snackbar.showMessage({
        show: true,
        color: "error",
        text: "Ocorreu um erro. Por favor tente mais tarde!",
        timeout: 4000,
      });
    }
  },
};
</script>


