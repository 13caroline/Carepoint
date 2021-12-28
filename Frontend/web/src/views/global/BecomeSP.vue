<template>
  <div>
      <Bar/>
    <v-container class="fill-height">
      <v-row justify="center" class="mb-4">
        <v-col cols="8">
          <v-row class="w-100">
            <h3 class="font-weight-regular text-uppercase subtitle">
              Registar como Prestador de Cuidados Individual
            </h3>
          </v-row>
          <v-row class="w-100">
            <p class="body-2 pb-5">Por favor preencha o seguinte formulário</p>
          </v-row>

          <v-form ref="form" v-model="valid">
            <v-row>
              <h3 class="pa-3 group font-weight-light text-uppercase">
                Dados Pessoais

              </h3>
                 
            </v-row>
            <v-row>
                         
<v-divider class="mb-4 mt-n2 divider"></v-divider>
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

            <v-row>

 <v-col >
                <span>Data de nascimento *</span>
                <v-menu
                  v-model="menu"
                  :close-on-content-click="false"
                  transition="scale-transition"
                  offset-y
                  min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                      v-model="date"
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
                    @input="menu = false"
                    locale="pt PT"
                    :max="new Date().toISOString().substr(0, 10)"
                  ></v-date-picker>
                </v-menu>
              </v-col>
            </v-row>


  


            <v-row> </v-row>
            <v-row>
              <h3 class="pa-3 group font-weight-light text-uppercase">
                Dados Profissionais
              </h3>
            </v-row>
            <v-row class="mb-4 mt-n2">
                <v-divider class="divider"></v-divider>
            </v-row>
            <v-row>
              <v-col class="py-0" cols="12" md="6" sm="6">
                <span>Localização *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  color="#78C4D4"
                  name="localization"
                  v-model="localization"
                  :rules="textRules"
                  required
                />
              </v-col>
              <v-col class="py-0" cols="12" md="6" sm="6">
                <span>Raio de Atividade *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  v-model="radius"
                  single-line
                  color="#78C4D4"
                  name="raius"
                  suffix="km"
                  type="number"
                  required
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
                  v-model="qualification"
                ></v-textarea>
              </v-col>
            </v-row>

            <span class="ma-0 caption">* Campos obrigatórios</span>

            <v-checkbox
              v-model="termos"
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
                type="submit"
                :disabled="!valid"
                @click="goToSub()"
                >Próximo</v-btn
              >
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
    <Foot/>
  </div>
</template>

<script>
export default {
  name: "BecomeSP",
  data() {
    return {
      menu: false,
      termos: false,
      dialogs: {},
      valid: false,
      date: new Date().toISOString().substr(0, 10),
      cancelar: { title: "o seu registo", text: "o seu registo" },
      textRules: [(v) => !!v || "Campo inválido"],
      name: "",
      contact: "",
      localization: "",
      radius: 0,
      qualification: "",
      description: "",
    };
  },
  components: {
    Cancel: () => import("@/components/dialogs/Cancel"),
    Foot: () => import("@/components/global/Footer"),
    Bar: () => import("@/components/global/AppBarAccount.vue"),

  },
  methods: {
    close() {
      this.$router.back();
    },
    goToSub(){
        this.$router.push('/register/subscription')
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

.divider{
    color: black;
}

::v-deep .my-checkbox .v-label {
  font-size: 12px;
}
</style>


