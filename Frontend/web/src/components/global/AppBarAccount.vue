<template>
  <div>
    <v-app-bar flat color="#78C4D4" height="100" elevation="3" class="mb-4">
      
      <v-row class="hidden-xs-only">
        <v-col sm="auto" md="auto" lg="auto" xl="8" offset-xs="0" offset-sm="3" offset-lg="4"> 
          <v-img
              id="logo_"
              class="logo"
              src="@/assets/logo_white.png"
              max-height="220"
              max-width="220"
            >
          </v-img>
        </v-col>
        <v-spacer></v-spacer>
        <v-col sm="auto" md="auto" lg="auto" xl="4">
          <v-menu
            offset-y
            open-on-hover
            offset-overflow
            v-if="$store.state.tipo != '4'"
          >
            <template v-slot:activator="{ on, attrs }">
              <!--<v-avatar v-bind="attrs" v-on="on" color="white">
                    <v-img
                      class="userImg ml-auto"
                      :src="processImage()"
                    >
                    </v-img>
                  </v-avatar>-->
              <v-btn dark class="white--text hidden-xs-only pb-10" text v-bind="attrs" v-on="on">
                Anúncios
                <v-icon class="ml-1" color="white" small
                  >fas fa-chevron-down</v-icon
                >
              </v-btn>
            </template>
            <v-list>
              <v-list-item>
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Anúncios')"
                  >Anúncios</v-list-item-title
                >
              </v-list-item>

              <v-divider></v-divider>

              <v-subheader  > Publicar </v-subheader>

              <v-list-item>
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Meus anúncios')"
                  >Os meus anúncios</v-list-item-title
                >
              </v-list-item>

              <v-list-item>
                <v-list-item-title
                  class="menuOpcao"
                  @click="processClick('Publicar anúncio')"
                  >Publicar anúncio</v-list-item-title
                >
              </v-list-item>
            </v-list>
          </v-menu>
        
          <v-divider vertical class="mx-sm-2 mx-md-2 mx-lg-2 mx-xl-2"></v-divider>
        
          <v-icon color="white" @click="messages()" class="mx-2 pb-10"
            >fas fa-comment-dots</v-icon
          >

          <v-icon color="white" @click="goToMainPage()" class="mx-2 pb-10"
            >fas fa-home</v-icon
          >

          <v-icon color="white" @click="logout()" class="mx-2 pb-10"
            >fas fa-sign-out-alt</v-icon
          >
        </v-col>
      </v-row>

      <v-row class="hidden-sm-and-up" no-gutters>
        <v-row no-gutters>
          <v-col cols="auto mb-"> 
            <v-img
                id="logo_"
                class="logo"
                src="@/assets/logo_white.png"
                max-height="220"
                max-width="220"
              >
            </v-img>
          </v-col>
        </v-row>
        <v-row no-gutters>
          <v-col cols="auto">
            <v-menu
              offset-y
              open-on-hover
              offset-overflow
              v-if="$store.state.tipo != '4'"
            >
              <template v-slot:activator="{ on, attrs }">
                <!--<v-avatar v-bind="attrs" v-on="on" color="white">
                      <v-img
                        class="userImg ml-auto"
                        :src="processImage()"
                      >
                      </v-img>
                    </v-avatar>-->
                <v-btn dark class="white--text ml-8 pb-3" text v-bind="attrs" v-on="on">
                  Anúncios
                  <v-icon class="ml-1" color="white" small
                    >fas fa-chevron-down</v-icon
                  >
                </v-btn>
              </template>
              <v-list>
                <v-list-item>
                  <v-list-item-title
                    class="menuOpcao mt-1"
                    @click="processClick('Anúncios')"
                    >Anúncios</v-list-item-title
                  >
                </v-list-item>

                <v-divider></v-divider>

                <v-subheader  > Publicar </v-subheader>

                <v-list-item>
                  <v-list-item-title
                    class="menuOpcao"
                    @click="processClick('Meus anúncios')"
                    >Os meus anúncios</v-list-item-title
                  >
                </v-list-item>

                <v-list-item>
                  <v-list-item-title
                    class="menuOpcao"
                    @click="processClick('Publicar anúncio')"
                    >Publicar anúncio</v-list-item-title
                  >
                </v-list-item>
              </v-list>
            </v-menu>
                    
            <v-icon color="white" @click="messages()" class="mx-2 pb-3"
              >fas fa-comment-dots</v-icon
            >

            <v-icon color="white" @click="goToMainPage()" class="mx-2 pb-3"
              >fas fa-home</v-icon
            >

            <v-icon color="white" @click="logout()" class="mx-2 pb-3"
              >fas fa-sign-out-alt</v-icon
            >
          </v-col>
        </v-row>
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
      switch (itemAtual) {
        case "Publicar anúncio":
          this.$router.push("/post/ad");
          break;
        case "Anúncios":
          if (store.getters.tipo == 2) this.$router.push("/page");
          else if (store.getters.tipo == 3)
            this.$router.push("/service/provider/ads");
          break;
        case "Meus anúncios":
          this.$router.push("/my/advertisements");
          break;
      }
    },
    goToMainPage() {
      let url = "";
      if (store.getters.tipo == "2") url = "/consumer/profile";
      else if (store.getters.tipo == "3") url = "/service/provider/page";
      else url = "/company/page";
      this.$router.push(url);
    },
    messages (){
      this.$router.push("/messages");
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
    /*processImage() {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(this.image)))
      );
    },*/
  },
  /*created: async function () {
    try {
      let response = await axios.post("http://localhost:9040/users/image", {
        token: store.getters.token,
      });
      this.image = response.data[0].image.data;
    } catch (e) {
      console.log(e);
    }
  },*/
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