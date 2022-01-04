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
          :disabled="dados == 0"
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

          <v-radio-group
            column
            v-model="radios"
            v-for="(v, index) in values"
            :key="index"
            class="small"
          >
            <v-radio
              v-if="dados.subscription < v.sub"
              :value="v.sub"
              :label="`${v.sub} meses`"
              color="#78C4D4"
              disabled
            ></v-radio>
            <v-radio
              v-else
              :value="v.sub"
              :label="`${v.sub} meses`"
              color="#78C4D4"
            ></v-radio>
             <span v-if="dados.type === '3'"> {{v.priceS}} </span>
          </v-radio-group>
         
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
                @click="confirm()"
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
                @click="confirm()"
              >
                Quero visibilidade!
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
    dialog: false,
    radios: 1,
    values: [
        { sub: 1, priceS: 9.99, priceC: 11.49},
        { sub: 3, priceS: 17.99, priceC: 27.59},
        { sub: 6, priceS: 29.99, priceC: 46.49 }
    ],
  }),
  methods: {
    confirm() {
      this.dialog = false;
    },
  },
};
</script>