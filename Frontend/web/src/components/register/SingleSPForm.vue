<template>
  <div>
    <v-container class="fill-height">
      <v-row justify="center" class="mb-4">
        <v-col cols="8">
          <v-row class="w-100">
            <h3 class="font-weight-regular text-uppercase">
              Registar como Prestador de Cuidados Individual
            </h3>
          </v-row>
          <v-row class="w-100">
            <p class="body-2 pb-5">Por favor preencha o seguinte formulário</p>
          </v-row>

          <v-form ref="form" v-model="valid">
            <v-row>
              <v-col class="py-0">
                <span>Nome completo *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  :rules="textRules"
                  color="#78C4D4"
                  v-model="form.name"
                  name="name"
                  required
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col class="py-0">
                <span>E-mail *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  v-model="form.email"
                  single-line
                  :rules="emailRules"
                  color="#78C4D4"
                  name="email"
                  required
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col cols="12" md="6" sm="6" class="py-0">
                <span>Palavra-passe *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  v-model="form.password"
                  :rules="passwordRules"
                  single-line
                  color="#78C4D4"
                  name="password"
                  :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                  @click:append="show1 = !show1"
                  :type="show1 ? 'text' : 'password'"
                  required
                />
              </v-col>
              <v-col class="py-0">
                <span>Repetir palavra-passe *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  v-model="form.password2"
                  :rules="[
                    form.password === form.password2 ||
                      'As palavra-passes devem corresponder.',
                  ]"
                  color="#78C4D4"
                  :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                  @click:append="show1 = !show1"
                  :type="show1 ? 'text' : 'password'"
                  required
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col class="py-0" cols="12" md="6" sm="6">
                <span>Contacto telefónico *</span>
                <v-text-field
                  prefix="+351"
                  outlined
                  flat
                  dense
                  single-line
                  color="#78C4D4"
                  name="contact"
                  v-model="form.phoneNumber"
                  maxlength="9"
                  :rules="[(v) => v.length > 8 || 'Contacto inválido']"
                  required
                  v-on:keypress="isNumber($event)"
                />
              </v-col>

              <v-col class="py-0" cols="12" md="6" sm="6">
                <span>Sexo *</span>
                <v-select
                  outlined
                  flat
                  dense
                  v-model="form.sex"
                  color="#78C4D4"
                  name="sex"
                  required
                  :items="items"
                  item-value="value"
                  item-text="name"
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col class="py-0">
                <span>Localização *</span>
                <v-autocomplete
                  outlined
                  flat
                  dense
                  v-model="form.location"
                  single-line
                  :items="loc"
                  item-value="idLocation"
                  item-text="name"
                  :rules="textRules"
                  color="#78C4D4"
                  name="location"
                  required
                />
              </v-col>
              <v-col class="py-0" cols="12" md="4" sm="4">
                <span>Raio de Atividade *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  v-model="form.distance"
                  single-line
                  color="#78C4D4"
                  name="raius"
                  suffix="km"
                  type="number"
                  required
                  v-on:keypress="isNumber($event)"
                />
              </v-col>
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
              <v-col class="py-0" cols="12" md="4" sm="4">
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
                <span>Data de nascimento *</span>
                <v-menu
                  v-model="menu"
                  :close-on-content-click="false"
                  :nudge-right="40"
                  transition="scale-transition"
                  offset-y
                  top
                  left
                  min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                      v-model="date"
                      append-icon="fas fa-calendar-alt"
                      readonly
                      color="#78c4d4"
                      dense
                      outlined
                      required
                      v-bind="attrs"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="date"
                    color="#78c4d4"
                    @input="menu = false"
                    locale="pt PT"
                    :max="new Date().toISOString().substr(0, 10)"
                  ></v-date-picker>
                </v-menu>
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
                  v-model="form.qualifications"
                ></v-textarea>
              </v-col>
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
                @click="next()"
                :disabled="!valid"
                >Próximo</v-btn
              >
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "SingleSPForm",
  data() {
    return {
      show1: false,
      menu: false,
      loc: [],
      termos: false,
      dialogs: {},
      valid: false,
      date: new Date().toISOString().substr(0, 10),
      cat: [],
      cancelar: { title: "o seu registo", text: "o seu registo" },
      emailRules: [
        (value) => !!value || "Campo inválido",
        (value) => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Campo inválido";
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
      textRules: [(v) => !!v || "Campo inválido"],
      form: {
        name: "",
        email: "",
        password: "",
        password2: "",
        phoneNumber: "",
        location: "",
        sex: "",
        type: "3",
        description: "",
        distance: "",
        qualifications: "",
        experience: "",
        categories: [],
      },
      items: [
        { name: "Feminino", value: "F" },
        { name: "Masculino", value: "M" },
        { name: "Indefinido", value: "I" },
      ],
    };
  },
  components: {
    Termos: () => import("@/components/dialogs/Terms"),
    Cancel: () => import("@/components/dialogs/Cancel"),
  },
  methods: {
    close() {
      this.$router.back();
    },
    next: async function () {
      if (this.$refs.form.validate()) {
        try {
          let res = await axios.post("http://localhost:9041/users/register", {
            name: this.form.name,
            email: this.form.email,
            password: this.form.password,
            sex: this.form.sex,
            type: this.form.type,
            location: this.form.location,
            phoneNumber: this.form.phoneNumber,
            description: this.form.description,
            dateOfBirth: this.date,
            distance: this.form.distance,
            qualifications: this.form.qualifications,
            categorias: this.form.categories,
            experience: this.form.experience, 
          });
          if (res.data.token != undefined) {
            this.$store.commit("guardaTokenUtilizador", res.data.token);
            this.$store.commit("guardaTipoUtilizador", this.form.type);
          }
          this.$router.push("/register/subscription/" + this.form.type);
        } catch (e) {
          this.$snackbar.showMessage({
            show: true,
            color: "warning",
            text: "Ocorreu um erro no registo, por favor tente mais tarde!",
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

    isNumber(e) {
      let char = String.fromCharCode(e.keyCode);
      if (/^[0-9]+$/.test(char)) return true;
      else e.preventDefault();
    },
  },

  created: async function () {
    try {
      let response = await axios.get("http://localhost:9040/location");
      if (response) {
        this.loc = response.data;
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
h3 {
  color: #78c4d4;
}

span {
  color: #797878;
  font-size: small;
}

::v-deep .my-checkbox .v-label {
  font-size: 12px;
}
</style>


