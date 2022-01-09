<template>
  <div>
    <v-dialog v-model="dialog" width="100%" max-width="500" persistent>
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="#78c4d4"
          depressed
          v-bind="attrs"
          v-on="on"
          dense
          outlined
          class="rounded-lg"
        >
          <v-icon small class="mr-1">fas fa-comment</v-icon>
          Deixar um comentário
        </v-btn>
      </template>
      <v-card class="rounded-lg">
        <v-card-title class="font-weight-bold pt-6">
          Deixar um comentário
        </v-card-title>
        <v-card-subtitle class="my-4 text-subtitle-1">
          O seu feedback é muito importante para avaliar a qualidade dos
          serviços prestados.
        </v-card-subtitle>
        <v-card-text>
          <v-form ref="form" v-model="valid">
            <h4 class="group font-weight-light text-uppercase">
              Classificação
            </h4>
            <v-divider></v-divider>
            <div class="text-center mt-3">
              <v-rating
                v-model="form.rating"
                :length="length"
                background-color="warning lighten-1"
                color="warning"
                hover
              ></v-rating>
            </div>

            <h4 class="mt-6 group font-weight-light text-uppercase">
              Comentário
            </h4>
            <v-divider></v-divider>
            <div class="text-center mt-3">
              <v-textarea
                auto-grow
                outlined
                v-model="form.description"
                flat
                rows="10"
                row-height="10"
                color="#78C4D4"
                required
              ></v-textarea>
            </div>
          </v-form>
        </v-card-text>

        <v-card-actions class="mt-0">
          <v-row class="mb-0">
            <v-col cols="12" md="6">
              <v-btn
                depressed
                large
                outlined
                dark
                block
                color="#78c4d4"
                @click="dialog = false"
              >
                Cancelar
              </v-btn>
            </v-col>
            <v-col cols="12" md="6">
              <v-btn
                depressed
                large
                dark
                block
                color="#78c4d4"
                @click="review()"
              >
                Confirmar
              </v-btn>
            </v-col>
          </v-row>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from 'axios';
import store from "@/store/index.js";

export default {
  props: ["dados"],
  data: () => ({
    dialog: false,
    length: 10,
    valid: false,
    form: {
      rating: 5,
      description: "",
    },
  }),
  methods: {
    review: async function () {
      if (this.$refs.form.validate()) {
        try {
            console.log(this.dados)
          await axios.post("http://localhost:9040/review", {
            token: store.getters.token,
            receivingId: this.dados,
            description: this.form.description,
            rating: this.form.rating,
          });

          this.$snackbar.showMessage({
            show: true,
            text: "Comentário enviado com sucesso.",
            color: "success",
            snackbar: true,
            timeout: 4000,
          });
        } catch (e) {
          this.$snackbar.showMessage({
            show: true,
            color: "warning",
            text: "Ocorreu um erro, por favor tente mais tarde!",
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
};
</script>

<style scoped>
.group {
  color: #282424;
  font-size: 20px;
}
</style>