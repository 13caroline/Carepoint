<template>
  <div>
    <v-app-bar flat color="#FFFFFF" height="180">
      <v-row justify="center" class="w-100">
        <v-col cols="7" md="4" sm="4" offset-md="4" offset-sm="3">
          <v-img
            id="logo_"
            class="logo"
            @click="goToMainPage()"
            src="@/assets/logo.png"
            max-height="220"
            max-width="220"
          >
          </v-img>
        </v-col>
        <v-col cols="5" md="2">
          <v-menu offset-y offset-overflow>
            <template v-slot:activator="{ on, attrs }">
              <v-img
                v-bind="attrs"
                v-on="on"
                class="userImg ml-auto"
                src="@/assets/userImgTest.jpg"
                max-height="70"
                max-width="70"
              >
              </v-img>
            </template>
            <v-list>
              <v-list-item v-for="(item, index) in items" :key="index">
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick(item)"
                  >{{ item.title }}</v-list-item-title
                >
              </v-list-item>
            </v-list>
          </v-menu>
        </v-col>
      </v-row>
    </v-app-bar>
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  name: "appbar",
  data() {
    return {
      items: [
        { title: "Anúncios" },
        { title: "Meus anúncios" },
        { title: "Perfil" },
        { title: "Publicar anúncio" },
        { title: "Terminar Sessão" },
      ],
      cardOptions: false,
    };
  },
  methods: {
    login() {
      this.$router.push("/");
    },
    acao() {
      console.log("Vai para página inicial");
    },
    processClick(itemAtual) {
      switch (itemAtual.title) {
        case "Perfil":
          this.$router.push("/consumer/profile");
          break;
        case "Publicar anúncio":
          this.$router.push("/consumer/post/ad");
          break;
        case "Anúncios":
          this.$router.push("/consumer/page");
          break;
        case "Terminar Sessão":
          this.logout();
          this.$router.push("/");
          break;
        case "Meus anúncios":
          this.$router.push("/consumer/my/advertisements");
      }
    },
    goToMainPage() {
      this.$router.push("/consumer/page");
    },
    logout: async function () {
      try {
        await axios.post("http://localhost:9041/users/logout", {
          token: store.getters.token,
        });
        this.$store.commit("limpaStore");
        this.$router.push("/");
      } catch (e) {
        this.$store.commit("limpaStore");
        this.$router.push("/");
      }
    },
  },
};
</script>

<style>
.userImg {
  border-radius: 50%;
  cursor: pointer;
}

.logo:hover {
  cursor: pointer;
}

.menuOpcao {
  cursor: pointer;
}

.menuOpcao:hover {
  font-weight: bold;
}

#logo_ {
  position:relative;
  top: 0px; 
  left: 70px;
}
</style>