<template>
  <div>
    <v-app-bar flat color="#78C4D4" height="100" elevation="3" class="mb-4">
      <v-row justify="center" class="w-100">
        <v-col cols="7" md="4" sm="4" offset-md="3" offset-sm="3">
          <v-img
            id="logo_"
            class="logo"
            @click="goToMainPage()"
            src="@/assets/logo_white.png"
            max-height="220"
            max-width="220"
          >
          </v-img>
        </v-col>
        <v-col cols="5" md="2">
          <v-menu offset-y offset-overflow>
            <template v-slot:activator="{ on, attrs }">
              <v-avatar v-bind="attrs" v-on="on" color="white">
                <v-img
                  class="userImg ml-auto"
                  :src="processImage()"
                >
                </v-img>
              </v-avatar>
            </template>
            <v-list>
              <v-list-item v-if="$store.state.tipo != '4'">
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Anúncios')"
                  >Anúncios</v-list-item-title
                >
              </v-list-item>
              <v-list-item v-if="$store.state.tipo != '4'">
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Meus anúncios')"
                  >Meus anúncios</v-list-item-title
                >
              </v-list-item>
              <v-list-item>
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Perfil')"
                  >Perfil</v-list-item-title
                >
              </v-list-item>
              <v-list-item v-if="$store.state.tipo != '4'">
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Publicar anúncio')"
                  >Publicar anúncio</v-list-item-title
                >
              </v-list-item>
              <v-list-item v-if="$store.state.tipo != '4'">
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Mensagens')"
                  >Mensagens</v-list-item-title
                >
              </v-list-item>
              <v-list-item>
                <v-list-item-title class="menuOpcao" @click="logout()"
                  >Terminar sessão</v-list-item-title
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
      image: null,
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
      switch (itemAtual) {
        case "Perfil":
          if (store.getters.tipo == 2) this.$router.push("/consumer/profile");
          else if (store.getters.tipo == 3)
            this.$router.push("/service/provider/page");
          else this.$router.push("/company/page");
          break;
        case "Publicar anúncio":
          this.$router.push("/post/ad");
          break;
        case "Anúncios":
          if (store.getters.tipo == 2) this.$router.push("/page");
          else if (store.getters.tipo == 3)
            this.$router.push("/service/provider/ads");
          break;
        case "Terminar Sessão":
          this.logout();
          this.$router.push("/");
          break;
        case "Meus anúncios":
          this.$router.push("/my/advertisements");
          break;
        case "Mensagens":
          this.$router.push("/messages");
      }
    },
    goToMainPage() {
      this.$router.push("/page");
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
    processImage() {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(this.image)))
      );
    },
  },
  created: async function () {
    try {
      let response = await axios.post("http://localhost:9040/users/image", {
        token: store.getters.token,
      });
      this.image = response.data[0].image.data;
    } catch (e) {
      console.log(e);
    }
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
  position: relative;
  top: 0px;
  left: 70px;
}
</style>