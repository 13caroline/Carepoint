<template>
  <div>
    <Bar />
    <v-container>
      <v-card flat>
        <v-row>
          <v-col cols="auto" class="ml-auto">
            <image-upload :id="user.idUser" @clicked="uploaded()" />
            <v-btn
              class="rounded-xl button hidden-xs-only"
              small
              color="#78C4D4"
              outlined
              dark
              to="/edit/profile"
            >
              <v-icon small class="mr-2">fas fa-pen</v-icon>
              Editar dados
            </v-btn>
            <v-btn
              class="rounded-xl button px-10 hidden-sm-and-up"
              small
              color="#78C4D4"
              outlined
              dark
              to="/edit/profile"
            >
              <v-icon small class="mr-2">fas fa-pen</v-icon>
              Editar dados
            </v-btn>

            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  class="body-2 ma-2"
                  small
                  color="#78C4D4"
                  v-bind="attrs"
                  v-on="on"
                  fab
                  dark
                  @click="wannaBeSP()"
                >
                  <v-icon small>fas fa-hand-holding-medical</v-icon>
                </v-btn>
              </template>
              <span class="caption">Quero ser prestador</span>
            </v-tooltip>
          </v-col>
        </v-row>

        <h3 class="group font-weight-light text-uppercase">Dados Pessoais</h3>
        <v-divider></v-divider>
        <v-row class="w-100" align="start">
          <v-col cols="12" sm>
            <v-card class="h-100 mt-5" outlined>
              <v-list-item>
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Nome</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.name }}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Localidade</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.locationName }}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos mb-0">Sexo</p>
                      </v-col>
                      <v-col>
                        <p class="respos mb-0">{{ user.sex }}</p>
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
          <v-col cols="auto" order="first" order-sm="last">
            <div class="foto h-100 mt-5">
              <v-img
                :src="processImage(user.image)"
                aspect-ratio="1"
                :width="115"
                class="
                  grey
                  lighten-2
                  my-2
                  ml-5 ml-sm-13 ml-md-13 ml-lg-13
                  rounded
                "
                cover
              >
                <template v-slot:placeholder>
                  <v-row
                    class="fill-height ma-0"
                    align="center"
                    justify="center"
                  >
                    <v-progress-circular
                      indeterminate
                      color="grey lighten-5"
                    ></v-progress-circular>
                  </v-row>
                </template>
              </v-img>
            </div>
          </v-col>
        </v-row>

        <h3 class="mt-6 group font-weight-light text-uppercase">
          Dados de Acesso
        </h3>
        <v-divider></v-divider>

        <v-row class="w-100" align="start">
          <v-col>
            <v-card class="h-100 mt-5" outlined>
              <v-list-item>
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">E-mail</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.email }}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos mb-0">Palavra-passe</p>
                      </v-col>
                      <v-col>
                        <p class="respos mb-0">*****</p>
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
        </v-row>

        <h3 class="mt-6 group font-weight-light text-uppercase">
          Dados de Contacto
        </h3>
        <v-divider></v-divider>
        <v-row class="w-100" align="start">
          <v-col>
            <v-card class="h-100 mt-5" outlined>
              <v-list-item>
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos mb-0">Contacto telefónico</p>
                      </v-col>
                      <v-col>
                        <p class="respos mb-0">{{ user.phoneNumber }}</p>
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
        </v-row>
      </v-card>
    </v-container>

    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  data() {
    return {
      user: {},
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    ImageUpload: () => import("@/components/dialogs/ImageUpload"),
    Foot: () => import("@/components/global/Footer"),
  },

  methods: {
    onPick() {
      this.$refs.fileInput.click();
    },
    wannaBeSP() {
      this.$router.push("/consumer/become/service/provider");
    },
    processImage(img) {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(img.data)))
      );
    },
    uploaded() {
      this.atualiza();
    },
    atualiza: async function () {
      try {
        let response = await axios.post("http://localhost:9040/users/perfil", {
          token: store.getters.token,
        });
        this.user = response.data.perfil[0];

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
  },
  created: async function () {
    this.atualiza();
  },
};
</script>


<style scoped>
.infos {
  text-align: start;
}
.respos {
  text-align: end;
  font-weight: bold;
}
.body-2 {
  font-size: 0.8rem !important;
}
.head {
  font-size: 2.75rem !important;
}
.font-weight-bold {
  font-size: 15px;
}
.font-weight-regular {
  font-size: 14px;
}
.font-weight-bold.col-sm-12.col-md-auto.col-auto {
  padding-bottom: 0;
}
.row.col.col-6 {
  margin-top: 0;
}
.foto {
  width: 170px;
}
.group {
  color: #282424;
  font-size: 20px;
}
.button:hover {
  background-color: #78c4d4;
  color: white !important;
}
</style>