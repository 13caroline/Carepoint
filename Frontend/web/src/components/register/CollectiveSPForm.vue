<template>
  <div>
    <v-container class="fill-height">
      <v-row justify="center" class="mb-4">
        <v-col cols="8">
          <v-row class="w-100">
            <h3 class="font-weight-regular text-uppercase">
              Registar como Prestador de Cuidados Coletivo
            </h3>
          </v-row>
          <v-row class="w-100">
            <p class="body-2 pb-5">Por favor preencha o seguinte formulário</p>
          </v-row>

          <v-form ref="form" v-model="valid">
            <v-row>
              <v-col class="py-0">
                <span>Nome *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  :rules="textRules"
                  color="#78C4D4"
                  v-model="name"
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
                  v-model="email"
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
                  v-model="password"
                  :rules="passwordRules"
                  single-line
                  color="#78C4D4"
                  name="password"
                  type="password"
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
                  v-model="password2"
                  :rules="passwordRules"
                  color="#78C4D4"
                  type="password"
                  required
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col class="py-0" cols="12" xs="12" md="4" sm="4">
                <span>Contacto telefónico *</span>
                <v-text-field
                  prefix="+351"
                  outlined
                  flat
                  dense
                  single-line
                  color="#78C4D4"
                  name="contact"
                  v-model="contact"
                  maxlength="9"
                  required
                />
              </v-col>
              <v-col class="py-0" cols="12" xs="12" md="8" sm="8">
                <span>Firma *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  color="#78C4D4"
                  name="firm"
                  v-model="firm"
                  :rules="textRules"
                  required
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col class="py-0 " cols="12" xs="12" md="3" sm="3">
                <span>NIPC *</span>
                <v-text-field
                  outlined
                  flat
                  color="#78C4D4"
                  required
                  dense
                  maxlength="9"
                  v-model="nipc"
                ></v-text-field>
              </v-col>
              <v-col class="py-0" cols="12" xs="12" md="9" sm="9">
                <span>Localização *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  color="#78C4D4"
                  required
                  :rules="textRules"
                  v-model="localization"
                ></v-text-field>
              </v-col>
            </v-row>

            <v-row>
              <v-col class="py-0">
                <span>Endereço do Sítio *</span>
                <v-text-field
                  outlined
                  flat
                  color="#78C4D4"
                  required
                  :rules="textRules"
                  v-model="site"
                ></v-text-field>
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
                  v-model="description"
                ></v-textarea>
              </v-col>
            </v-row>

            <span class="ma-0 caption">* Campos obrigatórios</span>

            <v-checkbox
              v-model="checkbox"
              :rules="[(v) => !!v || 'Aceite os Termos e Condições']"
              label="Li e aceito os Termos e Condições"
              required
              class="my-checkbox"
              color="#78c4d4"
            ></v-checkbox>
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
                :disabled="!valid"
                >Registar</v-btn
              >
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "SingleSPForm",
  data() {
    return {
      dialogs: {},
      valid: false,
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
      name: "",
      email: "",
      password: "",
      password2: "",
      contact: "",
      localization: "",
      site: "",
      firm: "", 
      description: "",
      nipc: "", 
    };
  },
  components: {
    Cancel: () => import("@/components/dialogs/Cancel"),
  },
  methods: {
    close() {
      this.$router.back();
    },
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
</style>


