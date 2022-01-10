<template>
  <div>
    <Bar />

    <v-container class="fill-height">
      <v-row justify="center">
        <v-col cols="12" class="mt-8">
          <h4 class="mx-4 font-weight-bold text-uppercase">Publicar Anúncio</h4>
          <v-card-subtitle>
            <p class="subtitle">
              Ao publicar um anúncio, os prestadores de cuidados disponíveis
              poderão visualizar a sua oferta de trabalho, facilitando a sua
              procura.
            </p>
          </v-card-subtitle>
                <v-form ref="form" v-model="valid">
          <v-card-text>
            <div>
              <span>Descrição *</span>
              <v-textarea
                auto-grow
                outlined
                flat
                rows="5"
                color="#78C4D4"
                required
                :rules="textRules"
                v-model="description"
              ></v-textarea>
            </div>

            <v-row>
              <v-col cols="12" md="6">
                <span>Data de início *</span>
                <v-menu
                  v-model="menu"
                  :close-on-content-click="false"
                  :nudge-right="40"
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
                      color="#78c4d4"
                      v-bind="attrs"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="date"
                    color="#78c4d4"
                    @input="menu = false"
                    locale="pt PT"
                    :min="new Date().toISOString().substr(0, 10)"
                  ></v-date-picker>
                </v-menu>
              </v-col>

              <v-col cols="12" md="6">
                <span>Data de término *</span>
                <v-menu
                  v-model="menu2"
                  :close-on-content-click="false"
                  :nudge-right="40"
                  transition="scale-transition"
                  offset-y
                  min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                      v-model="date2"
                      append-icon="fas fa-calendar-alt"
                      readonly
                      dense
                      outlined
                      required
                      v-bind="attrs"
                      color="#78c4d4"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="date2"
                    color="#78c4d4"
                    @input="menu2 = false"
                    locale="pt PT"
                    :min="new Date().toISOString().substr(0, 10)"
                  ></v-date-picker>
                </v-menu>
              </v-col>
            </v-row>

            <v-row class="mt-0">
              <v-col cols="12" md="6">
                <span>Área *</span>
                <v-select
                  flat
                  color="#78c4d4"
                  dense
                  outlined
                  label="Apoio a Idosos"
                  disabled
                  v-model="area"
                ></v-select>
              </v-col>

              <v-col cols="12" md="6">
                <span>Categoria *</span>
                <v-autocomplete
                  flat
                  color="#78c4d4"
                  dense
                  outlined
                  :rules="textRules"
                  :items="categoria"
                  v-model="category"
                  multiple
                  small-chips
                  required
                ></v-autocomplete>
              </v-col>
            </v-row>

            <v-row class="mt-0">
              <v-col cols="12" md="6">
                <span>Localização *</span>
                <v-text-field
                  flat
                  color="#78c4d4"
                  dense
                  outlined
                  :rules="textRules"
                  v-model="location"
                  required
                ></v-text-field>
              </v-col>

              <v-col cols="12" md="6">
                <span>Valor</span>
                <v-text-field
                  flat
                  color="#78c4d4"
                  dense
                  outlined
                  v-model="price"
                  suffix="€"
                ></v-text-field>
              </v-col>
            </v-row>

            <span class="ma-0 caption">* Campos obrigatórios</span>
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
                  @click="postAd()"
                                  :disabled="!valid"

                  >Publicar Anúncio</v-btn
                >
              </v-col>
            </v-row>
          </v-card-text>
                </v-form>
        </v-col>
      </v-row>
    </v-container>

    <Foot />
  </div>
</template>


<script>
import axios from "axios"
      import store from "@/store/index.js";

export default {
  data() {
    return {
      valid: false,
      menu: false,
      menu2: false,
      date: new Date().toISOString().substr(0, 10),
      date2: new Date().toISOString().substr(0, 10),
      categoria: [
        "Companhia",
        "Compras",
        "Higiene",
        "Medicação",
        "Passeios",
        "Refeições",
      ],
      description: "",
      price: 0,
      location: "",
      category: "",
      area: "",
      textRules: [(v) => !!v || "Campo inválido"],
      cancelar: {
        text: "a publicação de um anúncio",
        title: "publicação de um anúncio",
      },
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Cancel: () => import("@/components/dialogs/Cancel"),
    Foot: () => import("@/components/global/Footer"),
  },

  methods: {
    close() {
      this.$router.push("/consumer/profile");

    },

    postAd: async function(){
       if(this.$refs.form.validate()){
    try {
       await axios.post(
        "http://localhost:9040/joboffer/new",
        {
          token: store.getters.token,
          price: this.price,
          description: this.description,
          beginDate: this.date,
          endDate: this.date2,
          idUser: 207,
          idCategory: 1,
          idLocation: 1,
        }
      );
       this.$router.push("/consumer/my/advertisements")
          this.$snackbar.showMessage({
            show: true,
            color: "success",
            text: "Anúncio publicado",
            snackbar: true,
            timeout: 4000,
          });
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
  },
};
</script>

<style scoped>
span {
  color: #797878;
  font-size: small;
}

.subtitle {
  color: #78c4d4;
}
</style>