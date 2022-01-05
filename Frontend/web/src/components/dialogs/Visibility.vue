<template>
  <div>
    <v-dialog v-model="dialog" width="100%" max-width="460">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          dense
          color="#78c4d4"
          class="rounded-lg"
          depressed
          required
          v-bind="attrs"
          v-on="on"
          :disabled="dados.subscription == 0"
        >
          Subscrever
        </v-btn>
      </template>
      <v-card>
        <v-card-title class="justify-center cancel">
          Pretende visibilidade na sua subscrição?
        </v-card-title>
        <v-card-text>
          A visibilidade garante que os seus anúncios se encontrem sempre de
          entre os primeiros quando alguém pesquisar por serviços.

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
                    <v-row v-if="v.sub==1" justify="center"> {{ v.sub }} mês </v-row>
                    <v-row v-else justify="center"> {{ v.sub }} meses </v-row>
                  </v-card-title>

                  <v-card-text class="text-center">
                    <span v-if="dados.type === '3'"> +{{ v.priceS }} € </span>
                    <span v-else> +{{ v.priceC }} € </span>
                  </v-card-text>
                </v-card>
              </v-col>
            </v-row>
          </v-item-group>
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
                @click="confirm(0)"
              >
                Não, obrigado
              </v-btn>
            </v-col>
            <v-col cols="12" md="6">
              <v-btn
                depressed
                large
                dark
                block
                color="#78c4d4"
                @click="confirm(visibility)"
              >
                Quero visibilidade!
              </v-btn>
            </v-col>
          </v-row>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="dialog2" width="100%" max-width="460">
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
              <span class="black--text" v-if="dados.type === '3'">
                <strong>Prestador de Serviços Individual</strong>
              </span>
              <span class="black--text" v-if="dados.type === '4'">
                <strong>Prestador de Serviços Coletivo</strong>
              </span>
            </v-col>

            <v-col class="pb-0" align="right" cols="5">
              <span class="text-uppercase">Tipo de subscrição</span>
            </v-col>
            <v-col class="pl-0 pb-0" cols="7">
              <span class="black--text">
                <strong v-if="dados.subscription==1">{{ dados.subscription }} mês</strong>
                <strong v-else>{{ dados.subscription }} meses</strong> ({{
                  dados.price
                }}€)
              </span>
            </v-col>

            <v-col class="pb-0" align="right" cols="5">
              <span class="text-uppercase">Visibilidade</span>
            </v-col>
            <v-col class="pl-0 pb-0" cols="7">
              <span class="black--text">
                <strong v-if="visibility === 0">Não</strong>
                <strong v-else>Sim</strong>
              </span>
              <br />
              <span v-if="visibility !== 0 && visibility==1"
                >{{ visibility }} mês ({{ visibilityPrice }}€)</span
              >
              <span v-if="visibility !== 0 && visibility!=1"
                >{{ visibility }} meses ({{ visibilityPrice }}€)</span
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
  </div>
</template>

<script>
export default {
  props: ["dados"],
  data: () => ({
    price: 0,
    dialog: false,
    dialog2: false,
    visibility: 0,
    visibilityPrice: 0,
    total: 0,
    styleObject: { border: "1px solid #78C4D4" },
    radios: 1,
    values: [
      { sub: 0, priceS: 0, priceC: 0 },
      { sub: 1, priceS: 4, priceC: 3.5 },
      { sub: 3, priceS: 6, priceC: 9.6 },
      { sub: 6, priceS: 9, priceC: 16.5 },
    ],
  }),
  methods: {
    confirm(visible) {
      this.dialog = false;
      this.visibility = visible;
      this.dialog2 = true;
    },
    subscribe(v) {
      this.visibility = v.sub;
      if (this.dados.type === "3") this.visibilityPrice = v.priceS;
      else this.visibilityPrice = v.priceC;

      this.total =
        Math.round(
          (parseFloat(this.dados.price) + this.visibilityPrice) * 100
        ) / 100;
    },
    /*totalPrice() {
      var priceVisibility = 0;
      var row = this.values.filter((obj) => {
        return obj.sub === this.visibility;
      });
      if (this.dados.type === "3") priceVisibility = Object.values(row[0])[1];
      else priceVisibility = Object.values(row[0])[0];
      return (
        Math.round((parseFloat(this.dados.price) + priceVisibility) * 100) / 100
      );
    },*/

    register() {
      this.$emit("clicked", this.visibility);
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