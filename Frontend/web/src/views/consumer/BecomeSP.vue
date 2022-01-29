<template>
  <div>
    <Bar />
    <v-container class="fill-height">
      <v-row justify="center" class="mb-4">
        <v-col cols="8">
          <v-row class="w-100">
            <h3 class="font-weight-regular text-uppercase subtitle">
              Registar como Prestador de Cuidados Individual
            </h3>
          </v-row>
          <v-row class="w-100">
            <p class="body-2 pb-5">Por favor preencha o seguinte formulário.</p>
          </v-row>

          <v-form ref="form" v-model="valid">
            <h3 class="group font-weight-light text-uppercase">
              Dados pessoais
            </h3>
            <v-row>
              <v-divider class="mt-4 mb-4 divider"></v-divider>
            </v-row>
            <v-row>
              <v-col class="py-0">
                <span>Descrição *</span>
                <v-textarea
                  auto-grow
                  outlined
                  flat
                  rows="3"
                  row-height="15"
                  color="#78C4D4"
                  required
                  :rules="textRules"
                  v-model="form.description"
                ></v-textarea>
              </v-col>
            </v-row>

            <v-row>
              <v-col>
                <span>Data de nascimento *</span>
                <v-menu
                  v-model="menu"
                  :close-on-content-click="false"
                  transition="scale-transition"
                  offset-y
                  top
                  left
                  min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                      v-model="date"
                      color="#78C4D4"
                      append-icon="fas fa-calendar-alt"
                      readonly
                      dense
                      outlined
                      required
                      v-bind="attrs"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="date"
                    color="#78C4D4"
                    @input="menu = false"
                    locale="pt PT"
                    :max="new Date().toISOString().substr(0, 10)"
                  ></v-date-picker>
                </v-menu>
              </v-col>
            </v-row>

            <h3 class="mt-6 group font-weight-light text-uppercase">
              Dados profissionais
            </h3>
            <v-row>
              <v-divider class="mt-4 mb-4 divider"></v-divider>
            </v-row>

            <v-row>
              <v-col class="py-0">
                <span>Categorias *</span>
                <v-autocomplete
                  outlined
                  flat
                  dense
                  v-model="form.categories"
                  :items="cat"
                  item-value="idCategory"
                  item-text="name"
                  :rules="textRules"
                  color="#78C4D4"
                  name="categories"
                  required
                  chips
                  small-chips
                  multiple
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col class="py-0" cols="12" md="6" sm="6">
                <span>Raio de Atividade *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  v-model="form.radius"
                  single-line
                  color="#78C4D4"
                  name="raius"
                  suffix="km"
                  type="number"
                  required
                />
              </v-col>
              <v-col class="py-0" cols="12" md="6" sm="6">
                <span>Anos de Experiência *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  v-model="form.experience"
                  single-line
                  color="#78C4D4"
                  name="experience"
                  suffix="anos"
                  type="number"
                  required
                  v-on:keypress="isNumber($event)"
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col class="py-0">
                <span>Qualificações *</span>
                <v-textarea
                  auto-grow
                  outlined
                  flat
                  rows="2"
                  row-height="15"
                  color="#78C4D4"
                  required
                  :rules="textRules"
                  v-model="form.qualification"
                ></v-textarea>
              </v-col>
            </v-row>

            <span class="ma-0 caption">* Campos obrigatórios</span>

            <v-checkbox
              required
              class="my-checkbox"
              color="#78c4d4"
              v-model="termos"
              id="terms"
              :rules="[(v) => !!v || 'Aceite os Termos e Condições']"
            >
              <template v-slot:label>
                <div>
                  <Termos />
                </div>
              </template>
            </v-checkbox>
          </v-form>

          <v-row align="end" justify="end">
            <v-col cols="auto">
              <Cancel :dialogs="cancelar" @clicked="close()"></Cancel>
            </v-col>
            <v-col cols="auto" class="pl-0">
              <v-btn
                dense
                color="#78c4d4"
                class="rounded-lg white--text"
                required
                type="submit"
                :disabled="!valid"
                @click="confirm()"
                >Próximo</v-btn
              >
            </v-col>
          </v-row>
        </v-col>
      </v-row>

      <v-dialog v-model="dialog" width=auto persistent>
        <v-card id="dialog" class="rounded-lg">
          <v-card-title class="font-weight-bold pt-5">
            Confirmar palavra-passe
          </v-card-title>
          <v-card-subtitle> Confirme a sua palavra-passe para se tornar um prestador de serviços. </v-card-subtitle>
          <v-card-text >
            <v-form ref="form" v-model="valid">
              <v-divider></v-divider>
              <v-row class="mt-3">
                <v-col>
                  <span>Palavra-passe * </span>
                  <v-text-field
                    outlined
                    color="#78c4d4"
                    :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                    @click:append="show1 = !show1"
                    :type="show1 ? 'text' : 'password'"
                    required
                    dense
                    v-model="form.password"
                  ></v-text-field>
                </v-col>
              </v-row>
            </v-form>
          </v-card-text>

          <v-card-actions>
            <v-row align="end" justify="end">
              <v-col cols="auto">
                <Cancel :dialogs="cancelar" @clicked="close()"></Cancel>
              </v-col>
              <v-col cols="auto" class="pl-0">
                <v-btn
                  dense
                  color="#78c4d4"
                  class="rounded-lg white--text"
                  required
                  type="submit"
                  @click="next()"
                  :disabled="!form.password"
                  >Confirmar</v-btn
                >
              </v-col>
            </v-row>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-container>
    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  name: "BecomeSP",
  data() {
    return {
      menu: false,
      dialog: false,
      show1: false,
      termos: false,
      dialogs: {},
      cancelar: { title: "o seu registo", text: "o seu registo" },
      valid: false,
      cat: [],
      date: new Date().toISOString().substr(0, 10),
      textRules: [(v) => !!v || "Campo inválido"],
      numberRules: [
        (v) => {
          const pattern = /^[0-9]{9}$/;
          return pattern.test(v) || "Campo inválido. Insira 9 dígitos.";
        },
      ],
      form: {
        password: "",
        radius: "",
        qualification: "",
        description: "",
        experience: "",
        categories: [],
      },
      loc: [],
      user: {},
    };
  },
  components: {
    Cancel: () => import("@/components/dialogs/Cancel"),
    Termos: () => import("@/components/dialogs/Terms"),
    Foot: () => import("@/components/global/Footer"),
    Bar: () => import("@/components/global/AppBarAccount.vue"),
  },
  methods: {
    confirm(){
      this.dialog = true;
    },
    close() {
      this.$router.back();
    },
    isNumber(e) {
      let char = String.fromCharCode(e.keyCode);
      if (/^[0-9]+$/.test(char)) return true;
      else e.preventDefault();
    },
    next: async function () {
      if (this.$refs.form.validate()) {
        try {
          let res = await axios.post("http://localhost:9041/users/upgrade", {
            token: store.getters.token,
            password: this.form.password,
            description: this.form.description,
            dateOfBirth: this.date,
            distance: this.form.radius,
            qualifications: this.form.qualification,
            categories: this.form.categories,
            experience: this.form.experience,
          });
          if (res.data.token != undefined) {
            this.$store.commit("guardaTokenUtilizador", res.data.token);
            this.$store.commit("guardaTipoUtilizador", 3);
          }
          this.$router.push("/register/subscription/" + 3);
        } catch (error) {
          let message = "";
          (error.response.data.error == 'Password Inválida') ? message = "Palavra-passe incorreta." : message = "Ocorreu um erro, por favor tente mais tarde!";
          this.$snackbar.showMessage({
            show: true,
            color: "warning",
            text: message,
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
  },
  created: async function () {
    try {
      let response = await axios.post("http://localhost:9040/users/perfil", {
        token: store.getters.token,
      });
      console.log(response.data.perfil[0]);
      this.user = response.data.perfil[0];

      let response2 = await axios.get("http://localhost:9040/location");
      if (response2) {
        this.loc = response2.data;
      }
    } catch (e) {
      console.log(e);
    }

    try {
      let response3 = await axios.get("http://localhost:9040/category");
      if (response3) {
        this.cat = response3.data;
      }
    } catch (e) {
      console.log(e);
    }
  },
};
</script>

<style scoped>
.subtitle {
  color: #78c4d4;
}

span {
  color: #797878;
  font-size: small;
}

.divider {
  color: black;
}

::v-deep .my-checkbox .v-label {
  font-size: 12px;
}

.group {
  color: #282424;
  font-size: 20px;
}
#dialog{
overflow: hidden;
}
</style>


