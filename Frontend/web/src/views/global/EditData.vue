<template>
  <div>
    <app-bar-account />
    <v-container>
      <v-card flat>
        <h3 class="group font-weight-light text-uppercase">Dados de Acesso</h3>
        <v-divider></v-divider>
        <v-form ref="form" lazy-validation class="form">
          <v-row class="w-100" align="start">
            <v-col>
              <v-card class="h-100 mt-5" outlined>
                <v-list-item>
                  <v-list-item-content>
                    <div>
                      <v-col>
                        <span>E-mail</span>
                        <v-text-field
                          outlined
                          dense
                          v-model="user.email"
                        ></v-text-field>
                      </v-col>
                    </div>
                    <!--<div>
                      <v-col>
                        <span>Palavra-passe atual</span>
                        <v-text-field
                          type="password"
                          
                          outlined
                          dense
                          v-model="user.password"
                        ></v-text-field>
                      </v-col>
                    </div>-->
                    <div>
                      <v-row class="mx-auto">
                        <v-col cols="12" md="6">
                          <span>Nova palavra-passe</span>
                          <v-text-field
                            type="password"
                            placeholder="*****"
                            outlined
                            dense
                            v-model="password"
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" md="6">
                          <span>Repetir nova palavra-passe</span>
                          <v-text-field
                            type="password"
                            placeholder="*****"
                            outlined
                            dense
                            v-model="password"
                          ></v-text-field>
                        </v-col>
                      </v-row>
                    </div>
                  </v-list-item-content>
                </v-list-item>
              </v-card>
            </v-col>
          </v-row>

          <h3 class="mt-6 group font-weight-light text-uppercase">Dados Pessoais</h3>
          <v-divider></v-divider>
          <v-row class="w-100" align="start">
            <v-col>
              <v-card class="h-100 mt-5" outlined>
                <v-list-item>
                  <v-list-item-content>
                    <div>
                      <v-col>
                        <span>Nome</span>
                        <v-text-field
                          outlined
                          dense
                          v-model="user.name"
                          color="#2596be"
                          :rules="textRules"
                        ></v-text-field>
                      </v-col>
                    </div>
                    <v-row class="mx-auto">
                      <v-col cols="12" md="6">
                        <span>Localização</span>
                        <v-text-field
                          outlined
                          dense
                          color="#2596be"
                          :rules="textRules"
                          v-model="user.locationName"
                        ></v-text-field>
                      </v-col>
                   
                      <v-col cols="12" md="6">
                        <span>Sexo</span>
                        <v-select
                          outlined
                          color="#2596be"
                          :rules="textRules"
                          :items="user.sex"
                          dense
                          v-model="sex"
                        ></v-select>
                      </v-col>
                    </v-row>
                  </v-list-item-content>
                </v-list-item>
              </v-card>
            </v-col>
          </v-row>

          <h3 class="mt-6 group font-weight-light text-uppercase">Dados de Contacto</h3>
          <v-divider></v-divider>
          <v-row class="w-100" align="start">
            <v-col>
              <v-card class="h-100 mt-5" outlined>
                <v-list-item>
                  <v-list-item-content>
                    <div>
                      <v-col>
                        <span>Contacto Telefónico</span>
                        <v-text-field
                          outlined
                          dense
                          v-model="user.phoneNumber"
                          prefix="+351"
                          color="#2596be"
                          :rules="numberRules"
                          maxlength="9"
                        ></v-text-field>
                      </v-col>
                    </div>
                  </v-list-item-content>
                </v-list-item>
              </v-card>
            </v-col>
          </v-row>
        </v-form>
      </v-card>
      <v-row align="end" justify="end" class="w-100">
        <v-col cols="auto" >
          <Cancel :dialogs="cancelar" @clicked="close()"></Cancel>
        </v-col>
        <v-col cols="auto pl-0">
          <v-btn
            dense
            color="#78c4d4"
            depressed
            class="rounded-lg white--text"
            @click="editarDados()"
            >Confirmar</v-btn
          >
        </v-col>
      </v-row>
    </v-container>
    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  data: () => ({
    user: {},
    utilizador: {},
    password: "",
    sex: ["Feminino", "Masculino", "Indefinido"],
    textRules: [
      (v) => {
        const pattern = /^[a-zA-Z\sÀ-ÿ]+$/;
        return (
          pattern.test(v) ||
          "Campo inválido. Insira apenas caracteres do alfabeto."
        );
      },
    ],
    numberRules: [
      (v) => {
        const pattern = /^[0-9]{9}$/;
        return pattern.test(v) || "Campo inválido. Insira 9 dígitos.";
      },
    ],
    dialogs: {},
    cancelar: {
      text: "a edição de dados",
      title: "edição de dados",
    },
  }),
  methods: {
    close() {
      this.$router.push("/consumer/profile");
    },
  },
  components: {
    Cancel: () => import("@/components/dialogs/Cancel"),
    AppBarAccount: () => import("@/components/global/AppBarAccount"),
    Foot: () => import("@/components/global/Footer"),
  },
    created: async function () {
    try {
      console.log(store.getters.token)
      let response = await axios.post(
        "http://localhost:9040/users/perfil",
        {
          token: store.getters.token
        }
      );
      console.log(response.data)
      this.user = response.data.perfil[0];
    } catch (e) {
      this.$snackbar.showMessage({
        show: true,
        color: "error",
        text: "Ocorreu um erro. Por favor tente mais tarde!",
        timeout: 4000,
      });
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
.group {
  color: #282424;
  font-size: 20px;
}
span {
  color: #797878;
  font-size: small;
}
</style>