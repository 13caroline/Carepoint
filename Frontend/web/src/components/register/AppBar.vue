<template>
  <div>
    <v-container>
      <v-app-bar flat color="#FFFFFF" height="120">
        <v-row no-gutters class="w-100" >
          <v-col cols="9" md="6" sm="6" offset-md="4" offset-sm="3" offset="0">
            <v-img id="logo" src="@/assets/logo.png" max-height="270" max-width="270">
            </v-img>
          </v-col>
          <v-col cols="2" md="2" sm="2">
            <v-btn
              id="iniciar"
              outlined
              color="#78C4D4"
              depressed
              class="rounded-xl hidden-xs-only  ml-10"
              @click="login()"
            >
              Iniciar Sessão
            </v-btn>

            <v-menu id="menu" bottom left>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  text
                  v-bind="attrs"
                  v-on="on"
                  color="#78C4D4"
                  class="rounded-xl hidden-sm-and-up mt-4 ml-5"
                >
                  <v-icon>fas fa-bars</v-icon>
                </v-btn>
              </template>
              <v-list dense nav>
                <v-list-item
                  v-for="(item, i) in items"
                  :key="i"
                  @click="menuActionClick(item.action)"
                >
                  <v-list-item-icon>
                    <v-icon v-text="item.icon" small color="#78C4D4"></v-icon>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-list-item-title v-text="item.text"></v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
        </v-row>
      </v-app-bar>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "appbar",
  data() {
    return {
      items: [
        { text: "Iniciar Sessão", icon: "fas fa-sign-in-alt", action: "login" },
        { text: "FAQs", icon: "fas fa-question-circle", action: null },
      ],
    };
  },
  methods: {
    login() {
      this.$router.push("/");
    },

    menuActionClick(action) {
      if (action === "login") {
        this.login();
      }
    },
  },
};
</script>

<style scoped>

#logo {
  position: relative;
  top: 0px; 
  left: 50px;
  
}

#iniciar {
  position: relative;
  top: 20px; 
  left: -15px;
}

#menu {
  justify-self: start;
}

</style>