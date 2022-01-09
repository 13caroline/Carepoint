<template>
  <div>
    <v-dialog v-model="dialog" width="100%" max-width="460">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          dense
          color="#78c4d4"
          class="rounded-lg white--text"
          depressed
          required
          v-bind="attrs"
          v-on="on"
          :disabled="dados.subscription == 5"
          @click="matchingData()"
        >
          Subscrever
        </v-btn>
      </template>
      <v-card>
        <v-card-title class="justify-center cancel">
          Pretende visibilidade na sua subscrição?
        </v-card-title>
        <v-card-text>
          <div v-if="dados.subscription == 0">
            A opção de visibilidade não se encontra disponível para o período
            experimental.
          </div>
          <div v-else>
            A visibilidade garante que os seus anúncios se encontrem sempre de
            entre os primeiros quando alguém pesquisar por serviços.
          </div>
          <v-item-group>
            <v-row justify="center">
              <v-col
                cols="auto"
                class="mx-auto mx-sm-0"
                v-for="(v, index) in values"
                :key="index"
              >
                <v-card
                  v-if="v.sub > 0"
                  class="mt-4 rounded-xl overflow-auto prices"
                  outlined
                  tile
                  :style="styleObject"
                  @click="subscribe(v)"
                  :disabled="dados.subscription < v.sub"
                >
                  <v-card-title class="ma-2 card font-weight-normal">
                    <v-row v-if="v.sub == 1" justify="center">
                      {{ v.sub }} mês
                    </v-row>
                    <v-row v-else justify="center"> {{ v.sub }} meses </v-row>
                  </v-card-title>

                  <v-card-text class="text-center">
                    <span v-if="$store.state.tipo === '3'"> +{{ v.priceS }} € </span>
                    <span v-else> +{{ v.priceC }} € </span>
                  </v-card-text>
                </v-card>
              </v-col>
            </v-row>
          </v-item-group>
        </v-card-text>
        <v-card-actions>
          <v-row class="mb-0">
            <ConfirmSubscription :details="info" />
          </v-row>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import store from "@/store/index.js"
export default {
  props: ["dados"],
  components: {
    ConfirmSubscription: () =>
      import("@/components/dialogs/ConfirmSubscription"),
  },
  data: () => ({
    info: {
      visibilityPrice: 0,
      subscription: "",
      visibility: 0,
      price: 0,
      updated: 0,
    },
    dialog: false,
    styleObject: { border: "1px solid #78C4D4" },
    values: [
      { sub: 1, priceS: 4, priceC: 3.5 },
      { sub: 3, priceS: 6, priceC: 9.6 },
      { sub: 6, priceS: 9, priceC: 16.5 },
    ],
  }),
  methods: {
    subscribe(v) {
      this.info.visibility = v.sub;
      (store.state.tipo == 3)
      ? this.info.visibilityPrice = v.priceS
      : this.info.visibilityPrice = v.priceC;
    },
    matchingData() {
        this.info.price = this.dados.price;
        this.info.subscription = this.dados.subscription;
        this.info.updated = this.dados.updated;
    }
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