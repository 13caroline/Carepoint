<template>
    <div>
        <Bar />

        <v-container>
        <v-card flat>
        <v-row>
          <v-col cols="auto" class="ml-auto">
            <v-btn
              class="body-2 mr-2"
              small
              color="#2596be"
              dark
              @click="addFoto()"
            >
              Adicionar fotografia
              <v-icon small class="ml-2">fas fa-camera</v-icon>
            </v-btn>
            <v-btn
              class="body-2"
              small
              color="#2596be"
              dark
              to="/cliente/prefencias/editar"
            >
              Editar dados
              <v-icon small class="ml-2">fas fa-pen</v-icon>
            </v-btn>
          </v-col>
        </v-row>

        <h3 class="pa-3">Dados Pessoais</h3>
        <v-divider></v-divider>
        <v-row class="w-100 ma-0" align="start">
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
                        <p class="infos mb-0">Sexo</p>
                      </v-col>
                      <v-col>
                        <p class="respos mb-0">Feminino</p>
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

        <h3 class="pa-3">Dados de Acesso</h3>
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

        <h3 class="pa-3">Dados de Contacto</h3>
        <v-divider></v-divider>
        <v-row class="w-100" align="start">
          <v-col>
            <v-card class="h-100 mt-5" outlined>
              <v-list-item>
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos mb-0">Número de telefone</p>
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
    return {
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
  },
  computed: {
  },
  methods: {
    onPick() {
      this.$refs.fileInput.click();
    },
    
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
</style>