<template>
  <div>
    <v-container>
      <v-app-bar flat color="#FFFFFF" height="120">
        <v-row justify="center" class="w-100">
          <v-col cols="7" md="4" offset-md="4">
            <v-img src="@/assets/logo.png" max-height="270" max-width="270">
            </v-img>
          </v-col>
          <v-col cols="5" md="2">
            <v-btn outlined color="#78C4D4" depressed class="rounded-xl hidden-xs-only" @click="login()"> 
              Iniciar Sessão
            </v-btn>

            <v-menu offset-y>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  text
                  v-bind="attrs"
                  v-on="on"
                  outlined color="#78C4D4" 
                  class="rounded-xl hidden-sm-and-up"
                >
                  <v-icon>mdi-format-list-bulleted-square</v-icon>
                </v-btn>
              </template>
              <v-list dense nav>  
                <v-list-item v-for="(item, i) in items" :key="i" @click="menuActionClick(item.action)">
                  <v-list-item-icon>
                    <v-icon v-text="item.icon"></v-icon>
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
        { text: 'Iniciar Sessão', icon: 'mdi-view-dashboard', action: "login" },
        { text: 'Ajuda', icon: 'mdi-view-dashboard', action: null },
      ],
      
    };
  },
  methods: {
    login() {
      this.$router.push("/");
    },

    menuActionClick(action) {
      if (action === "login") {
        this.login()
      } 
    }

  }
};
</script>