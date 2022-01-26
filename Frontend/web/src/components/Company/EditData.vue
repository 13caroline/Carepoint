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
                          disabled
                          dense
                          v-model="user.email"
                        ></v-text-field>
                      </v-col>
                    </div>
                     <v-row class="mx-auto" align="center">
                      <v-col md="10">
                      <span>Password</span>
                      <v-text-field
                        outlined
                        disabled
                        dense
                        placeholder="*******"
                      ></v-text-field>
                      </v-col>
                        <v-col>
                      <change-password :id="user.idUser" @clicked="update()"/>
                      </v-col>
                    </v-row>
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
                    <!--<div>
                      <v-row class="mx-auto">
                        <v-col cols="12" md="6">
                          <span>Nova palavra-passe</span>
                          <v-text-field
                            type="password"
                            :rules="passwordRules"
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
                            :rules="[(this.password === this.npassword) || 'Password must match']"
                            v-model="npassword"
                          ></v-text-field>
                        </v-col>
                      </v-row>
                    </div> -->
                  </v-list-item-content>
                </v-list-item>
              </v-card>
            </v-col>
          </v-row>

          <h3 class="mt-6 group font-weight-light text-uppercase">
            Dados da empresa
          </h3>
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
                        ></v-text-field>
                      </v-col>
                    </div>
                    <v-row class="mx-auto">
                      <v-col>
                        <span>URL</span>
                        <v-text-field
                          outlined
                          dense
                          color="#2596be"
                          v-model="user.link"
                        ></v-text-field>
                      </v-col>
                    </v-row>
                    <v-row class="mx-auto">
                      <v-col>
                        <span>Firma</span>
                        <v-text-field
                          outlined
                          dense
                          color="#2596be"
                          :rules="textRules"
                          v-model="user.firm"
                        ></v-text-field>
                      </v-col>
                    </v-row>
                    <v-row class="mx-auto">
                      <v-col>
                        <span>NIPC</span>
                        <v-text-field
                          outlined
                          maxlength="9"
                          dense
                          :rules="numberRules"
                          color="#2596be"
                          v-model="user.nipc"
                          v-on:keypress="isNumber($event)"
                        ></v-text-field>
                      </v-col>
                    </v-row>
                    <v-row class="mx-auto">
                      <v-col>
                        <span>Localização</span>
                        <v-text-field
                          outlined
                          dense
                          color="#2596be"
                          :rules="textRules"
                          v-model="user.locationName"
                        ></v-text-field>
                      </v-col>
                    </v-row>
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
          <div >
            <h3 class="mt-6 group font-weight-light text-uppercase">
              Informações
            </h3>
            <v-divider></v-divider>
            <v-row class="w-100" align="start">
              <v-col>
                <v-card class="h-100 mt-5" outlined>
                  <v-list-item>
                    <v-list-item-content>
                      <div>
                        <v-col>
                          <span>Descrição</span>
                          <v-text-field
                            outlined
                            dense
                            v-model="user.description"
                            color="#2596be"
                          ></v-text-field>
                        </v-col>
                      </div>
                      
                     
                    </v-list-item-content>
                  </v-list-item>
                </v-card>
              </v-col>
            </v-row>
          </div>
        </v-form>
      </v-card>
      <v-row align="end" justify="end" class="w-100">
        <v-col cols="auto">
          <Cancel :dialogs="cancelar" @clicked="close()"></Cancel>
        </v-col>
        <v-col cols="auto pl-0">
          <v-btn
            dense
            color="#78c4d4"
            depressed
            class="rounded-lg white--text"
            @click="confirm()"
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
    passwordRules: [
      (v) => !!v || "Palavra-passe inválida",
      (v) => /(?=.*[A-Z])/.test(v) || "Deve ter uma letra maiúscula",
      (v) => /(?=.*\d)/.test(v) || "Deve ter um número",
      (v) =>
        (v && v.length >= 5) ||
        "A palavra-passe deve ter pelo menos 5 caracteres",
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
    isNumber(e) {
      let char = String.fromCharCode(e.keyCode);
      if (/^[0-9]+$/.test(char)) return true;
      else e.preventDefault();
    },

    confirm: async function () {
      if (this.$refs.form.validate()) {
        try {
          let response = await axios.put("http://localhost:9040/users/update", {
            token: store.getters.token,
            name: this.user.name,
            email: this.user.email,
            type: store.getters.tipo.toString(),
            location: 1,
            phoneNumber: this.user.phoneNumber,
            idUser: this.user.idUser,
            description: this.user.description,
            link: this.user.link,
            firm: this.user.firm,
            nipc: this.user.nipc,
          });
          console.log(response);
          this.$router.push("/service/provider/page");

          this.$snackbar.showMessage({
            show: true,
            text: "Dados atualizados com sucesso.",
            color: "success",
            snackbar: true,
            timeout: 4000,
          });
        } catch (e) {
          console.log(e);
          this.$snackbar.showMessage({
            show: true,
            color: "warning",
            text: "Ocorreu um erro no processamento, por favor tente mais tarde!",
            timeout: 4000,
          });
        }
      } else {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Por favor preencha todos os campos.",
          timeout: 4000,
        });
      }
    },
    update: async function(){
        try {
      let response = await axios.post("http://localhost:9040/users/perfil", {
        token: store.getters.token,
      });
      this.user = response.data.perfil[0];
      console.log(response.data);
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
    }
  },
  components: {
    Cancel: () => import("@/components/dialogs/Cancel"),
    AppBarAccount: () => import("@/components/global/AppBarAccount"),
    Foot: () => import("@/components/global/Footer"),
    ChangePassword: () => import("@/components/dialogs/ChangePassword")

  },
  created: async function () {
  this.update();
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