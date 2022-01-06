<template>
  <v-container>
    <v-item-group>
      <v-row>
        <v-col
          cols="12"
          lg="4"
          md="4"
          sm="4"
          v-for="s in sub"
          :key="s.type"
        >
          <div class="user">
            <v-card
              class="card rounded-xl overflow-auto"
              outlined
              tile
              :style="styleObject"
              height="450"
              width="450"
            >
              <v-card-title class="mb-5 mx-5">
                <v-row justify="center">
                  {{ s.type }}
                </v-row>
              </v-card-title>

              <v-card-text>
                <v-row
                  class="mx-auto"
                  v-for="(p, index) in s.pros"
                  :key="index"
                >
                  <v-col cols="9" md="9" sm="9">
                    <span>
                      {{ p.title }}
                    </span>
                  </v-col>

                  <v-col cols="3" md="3" sm="3">
                    <v-icon smal :color="p.color">
                      {{ `fas fa-${p.icon}` }}
                    </v-icon>
                  </v-col>
                </v-row>

                <v-row>
                  <v-col class="mx-auto">
                  <v-checkbox
              v-model="termos"
              :rules="[(v) => !!v || 'Aceite os Termos e Condições']"
              label="Pretendo maior visibilidade"
              required
              class="my-checkbox"
              color="#78c4d4"
            ></v-checkbox>
            </v-col>
                </v-row>

                <v-row justify="center" class="mx-auto">
                  <span class="price">{{ s.priceS }}</span>
                </v-row>
              </v-card-text>

              <v-card-actions class="mt-4">
                <v-row justify="center" class="mx-auto">
                  <v-btn
                    depressed
                    dark
                    color="#78c4d4"
                    type="submit"
                    class="rounded-lg"
                  >
                    Subscrever
                  </v-btn>
                </v-row>
              </v-card-actions>
            </v-card>
          </div>
        </v-col>
      </v-row>
    </v-item-group>
  </v-container>
</template>

<script>
export default {
  name: "Ads",

  data() {
    return {
      styleObject: { border: "1px solid #78C4D4" },
      sub: [
        {
          type: "Subscrição Mensal",
          pros: [
            { title: "Publicar anúncios", icon: "check", color: "#AED581" },
            { title: "Adicionar agenda", icon: "check", color: "#AED581" },
            {
              title: "Visualizar pedidos de consumidores",
              icon: "times",
              color: "#EF9A9A",
            },
            {
              title: "1 mês de visibilidade gratuito",
              icon: "times",
              color: "#EF9A9A",
            },
          ],
          priceS: "4.99€",
        },
        {
          type: "Subscrição Trimestral",
          pros: [
            { title: "Publicar anúncios", icon: "check", color: "#AED581" },
            { title: "Adicionar agenda", icon: "check", color: "#AED581" },
            {
              title: "Visualizar pedidos de consumidores",
              icon: "check",
              color: "#AED581",
            },
            {
              title: "1 mês de visibilidade gratuito",
              icon: "times",
              color: "#EF9A9A",
            },
          ],
          priceS: "11.99€",
        },
        {
          type: "Subscrição Semestral",
          pros: [
            { title: "Publicar anúncios", icon: "check", color: "#AED581" },
            { title: "Adicionar agenda", icon: "check", color: "#AED581" },
            {
              title: "Visualizar pedidos de consumidores",
              icon: "check",
              color: "#AED581",
            },
            {
              title: "1 mês de visibilidade gratuito",
              icon: "check",
              color: "#AED581",
            },
          ],
          priceS: "19.99€",
        },
      ],
    };
  },
};
</script>

<style scoped>
.description {
  text-align: justify;
  text-justify: auto;
  color: grey;
  margin-top: 2em;
}

.activity {
  font-size: smaller;
}


::v-deep .my-checkbox .v-label {
  font-size: 12px;
}

.price {
  color: grey;
  font-size: 20px;
}
</style>