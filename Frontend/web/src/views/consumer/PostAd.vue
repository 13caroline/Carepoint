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
                  rows="3"
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
                      :min="date"
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
                    :items="cat"
                    item-value="idCategory"
                    item-text="name"
                    v-model="category"
                    small-chips
                    required
                  ></v-autocomplete>
                </v-col>
              </v-row>

              <v-row class="mt-0">
                <v-col cols="12" md="6">
                  <span>Localização *</span>
                  <v-autocomplete
                    flat
                    color="#78c4d4"
                    dense
                    outlined
                    :rules="textRules"
                    v-model="location"
                    :items="loc"
                    item-value="idLocation"
                    item-text="name"
                    required
                  />
                </v-col>

                <v-col cols="12" md="6">
                  <span>Valor</span>
                  <v-text-field
                    flat
                    color="#78c4d4"
                    dense
                    outlined
                    v-model="price"
                    suffix="€/hora"
                    type="number"
                    required
                    v-on:keypress="isNumber($event)"
                  ></v-text-field>
                </v-col>
              </v-row>

              <v-row align="end" justify="end">
                <v-col cols="auto">
                  <span> Valor a pagar: <strong> 1.99€ </strong> </span>
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
    <top-button />
    <Foot />
  </div>
</template>


<script>
import axios from "axios";
import store from "@/store/index.js";

export default {
  data() {
    return {
      valid: false,
      menu: false,
      menu2: false,
      date: new Date().toISOString().substr(0, 10),
      date2: new Date().toISOString().substr(0, 10),
      loc: [],
      cat: [],
      description: "",
      price: "",
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
    TopButton: () => import("@/components/global/TopButton"),
    Foot: () => import("@/components/global/Footer"),
  },

  methods: {
    close() {
      store.getters.tipo == 2
        ? this.$router.push("/my/advertisements")
        : this.$router.push("/service/provider/page");
    },
    isNumber(e) {
      let char = String.fromCharCode(e.keyCode);
      if (/^[0-9]+$/.test(char)) return true;
      else e.preventDefault();
    },

    postAd: async function () {
      if (this.$refs.form.validate()) {
        if (!this.price) this.price = 0;
        try {
          await axios.post("http://localhost:9040/joboffer/new", {
            token: store.getters.token,
            price: this.price,
            description: this.description,
            beginDate: this.date,
            endDate: this.date2,
            idCategory: this.category,
            idLocation: this.location,
          });
          this.$router.push("/my/advertisements");
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
      let response2 = await axios.get("http://localhost:9040/category");
      if (response2) {
        this.cat = response2.data;
      }
    } catch (e) {
      console.log(e);
    }
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