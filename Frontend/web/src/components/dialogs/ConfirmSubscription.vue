<template>
  <v-dialog v-model="dialog2" width="100%" max-width="460">
    <template v-slot:activator="{ on, attrs }">
      <v-col cols="12" md="6">
        <v-btn
          depressed
          large
          outlined
          dark
          block
          v-bind="attrs"
          v-on="on"
          color="#78c4d4"
          @click="confirm(0)"
        >
          Não, obrigado
        </v-btn>
      </v-col>
      <v-col cols="12" md="6">
        <v-btn
          depressed
          large
          v-bind="attrs"
          v-on="on"
          class="white--text"
          block
          color="#78c4d4"
          :disabled="details.visibility == 0"
          @click="confirm(details.visibility)"
        >
          Quero visibilidade!
        </v-btn>
      </v-col>
    </template>
    <v-card>
      <v-card-title class="justify-center cancel">
        Confirmar subscrição
      </v-card-title>
      <v-card-text>
        <v-row class="mt-2">
          <v-col class="pb-0" align="right" cols="5">
            <span class="text-uppercase">Utilizador</span>
          </v-col>
          <v-col class="pl-0 pb-0" cols="7">
            <span class="black--text" v-if="$store.state.tipo === '4'">
              <strong>Prestador de Serviços Coletivo</strong>
            </span>
            <span class="black--text" v-else>
              <strong>Prestador de Serviços Individual</strong>
            </span>
          </v-col>

          <v-col class="pb-0" align="right" cols="5">
            <span class="text-uppercase">Tipo de subscrição</span>
          </v-col>
          <v-col class="pl-0 pb-0" cols="7">
            <span class="black--text">
              <strong v-if="details.subscription == 0"
                >Período Experimental</strong
              >
              <strong v-if="details.subscription == 1"
                >{{ details.subscription }} mês</strong
              >
              <strong
                v-if="details.subsciption == 3 && details.subscription == 6"
                >{{ details.subscription }} meses</strong
              >
              ({{ details.price }}€)
            </span>
          </v-col>

          <v-col class="pb-0" align="right" cols="5">
            <span class="text-uppercase">Visibilidade</span>
          </v-col>
          <v-col class="pl-0 pb-0" cols="7">
            <span class="black--text">
              <strong v-if="details.visibility === 0">Não</strong>
              <strong v-else>Sim</strong>
            </span>
            <br />
            <span v-if="details.visibility !== 0 && details.visibility == 1"
              >{{ details.visibility }} mês ({{
                details.visibilityPrice
              }}€)</span
            >
            <span v-if="details.visibility !== 0 && details.visibility != 1"
              >{{ details.visibility }} meses ({{
                details.visibilityPrice
              }}€)</span
            >
          </v-col>

          <v-col class="pb-0" align="right" cols="5">
            <span class="text-uppercase">Valor a pagar</span>
          </v-col>
          <v-col class="pl-0 pb-0" cols="7">
            <span class="black--text">
              <strong>{{ total }} €</strong>
            </span>
          </v-col>
        </v-row>
      </v-card-text>
      <v-card-actions>
        <v-row class="mb-0">
          <v-col cols="12" md="6">
            <v-btn
              depressed
              large
              outlined
              dark
              block
              color="#78c4d4"
              @click="dialog2 = false"
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
              @click="register()"
            >
              Registar
            </v-btn>
          </v-col>
        </v-row>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  props: ["details"],
  data: () => ({
    dialog2: false,
    total: 0,
  }),
  methods: {
    confirm(visible) {
      this.total = 0;
      if (visible == 0){ 
        this.details.visibilityPrice = 0;
        this.details.visibility = 0; 
      }

      this.total =
        Math.round(
          (parseFloat(this.details.price) + this.details.visibilityPrice) * 100
        ) / 100;

      this.dialog2 = true;
    },

    register: async function () {
      try {
        await axios.post("http://localhost:9040/subscription/", {
          token: store.getters.token,
          subscription: this.details.subscription.toString(),
          visibility: this.details.visibility.toString(),
        });
        store.state.tipo == 3
          ? this.$router.push("/service/provider/page")
          : this.$router.push("/company/page");

        this.details.updated === 0
          ? (this.text = "Bem-vindo ao Carepoint!")
          : (this.text = "Subscrição renovada com sucesso!");
        this.$snackbar.showMessage({
          show: true,
          color: "#78c4d4",
          text: this.text,
          snackbar: true,
          timeout: 4000,
        });
      } catch (error) {
        this.$snackbar.showMessage({
          show: true,
          snackbar: true,
          color: "warning",
          text: "Ocorreu um erro. Por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
  },
};
</script>

<style scoped>
.prices:hover {
  background-color: #c0e4ec;
}

.card {
  color: #78c4d4;
}
</style>