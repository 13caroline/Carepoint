<template>
  <div>
    <Bar />
    <v-container>
      <v-card flat>
        <v-row>
          <v-col cols="auto" class="ml-auto">
            <image-upload />
            <v-btn
              class="body-2 rounded-xl button"
              small
              color="#78C4D4"
              outlined
              dark
              to="/consumer/edit/profile"
            >
              Editar dados
              <v-icon small class="ml-2">fas fa-pen</v-icon>
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

        <h3 class="pa-3 group font-weight-light text-uppercase">
          Dados Pessoais
        </h3>
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
                        <p class="respos">Nome de pessoa</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Localidade</p>
                      </v-col>
                      <v-col>
                        <p class="respos">Morada</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Sexo</p>
                      </v-col>
                      <v-col>
                        <p class="respos">Feminino</p>
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
                src="@/assets/userImgTest.jpg"
                aspect-ratio="1"
                class="grey lighten-2 mx-2 rounded"
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
                        <p class="respos">email@email.com</p>
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
                        <p class="respos mb-0">915293745</p>
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
export default {
  data() {
    return {};
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
    wannaBeSP(){
      this.$router.push('/consumer/become/service/provider')
    }
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