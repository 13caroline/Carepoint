<template>
  <div>
    <v-app-bar flat color="#FFFFFF" height="180">
      <v-row justify="center" class="w-100">
        <v-col cols="7" md="4" offset-md="4">
          <v-img
            class="logo"
            @click="acao()"
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
export default {
  name: "appbar",
  data() {
    return {
      items: [
        { title: "Perfil" },
        { title: "Publicar anúncio" },
        { title: "Anúncios" },
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
      console.log(itemAtual.title);
      switch (itemAtual.title) {
        case "Perfil":
          this.$router.push("/global/profile");
          break;
        case "Publicar anúncio":
          console.log("Vai para publicar anuncio");
          break;
        case "Anúncios":
          console.log("Vai para Anúncios");
          break;
        case "Terminar Sessão":
          console.log("Terminar Sessão");
          break;
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
</style>