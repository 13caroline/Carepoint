<template>
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
            @click="redirect()"
          >
            Editar dados
            <v-icon small class="ml-2">fas fa-pen</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <div v-if="$store.state.tipo != '4'">
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
                        <p class="infos">Sexo</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.sex }}</p>
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
      </div>

      <div v-else>
        <h3 class="group font-weight-light text-uppercase">Dados da empresa</h3>
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
                        <p class="infos">URL</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.link }}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Firma</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.firm }}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">NIPC</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.nipc }}</p>
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
      </div>

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

      <div v-if="$store.state.tipo != '4'">
        <h3 class="mt-6 group font-weight-light text-uppercase">Informações</h3>
        <v-divider></v-divider>

        <v-row class="w-100" align="start">
          <v-col>
            <v-card class="h-100 mt-5" outlined>
              <v-list-item>
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Raio de atividade</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.distance }} km</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Descrição</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.description }}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Qualificações</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{ user.qualifications }}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos mb-0">Categorias</p>
                      </v-col>
                      <v-col>
                        <!--<p v-for="(c,index) in categories" :key="index" class="respos mb-0">nameC</p> -->
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
        </v-row>
      </div>
      <div v-if="$store.state.tipo == '4'">

        <h3 class="mt-6 group font-weight-light text-uppercase">Informações</h3>
        <v-divider></v-divider>

        <v-row class="w-100" align="start">
        <v-col>
          <v-card class="h-100 mt-5" outlined>
            <v-list-item>
              <v-list-item-content>
                <div>
                  <v-row>
                    <v-col>
                      <p class="infos">Descrição</p>
                    </v-col>
                    <v-col>
                      <p class="respos">{{ user.description }}</p>
                    </v-col>
                  </v-row>
                </div>
              </v-list-item-content>
            </v-list-item>
          </v-card>
        </v-col>
      </v-row>

      </div>
    </v-card>
  </v-container>
</template>

<script>
export default {
  props: ["user", "categories"],
  data() {
    return {};
  },
  components: {
    ImageUpload: () => import("@/components/dialogs/ImageUpload"),
  },
  methods:{
    redirect(){
      if(this.$store.getters.tipo=='3')this.$router.push("/edit/profile")
      else this.$router.push("/company/edit/profile")
    }
  }
};
</script>

<style scoped>
.respos {
  text-align: end;
  font-weight: bold;
}

.infos {
  text-align: start;
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