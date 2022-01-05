<template>
  <v-container>
    <v-item-group>
      <v-row justify="center">
        <v-col
          cols="auto"
          class="mx-auto mx-sm-0"
          v-for="s in sub"
          :key="s.name"
        >
          <v-card
            class="card rounded-xl overflow-auto"
            outlined
            tile
            :style="styleObject"
            height="400"
            @click="subscribe(s)"
          >
            <v-card-title class="ma-5">
              <v-row justify="center">
                {{ s.name }}
              </v-row>
            </v-card-title>

            <v-card-text>
              <v-row
                justify="center"
                class="mx-auto"
                v-for="(p, index) in s.pros"
                :key="index"
              >
                <v-col cols="12" md="9" sm="7">
                  <span>
                    {{ p.title }}
                  </span>
                </v-col>

                <v-col cols="12" md="3" sm="2">
                  <v-icon smal :color="p.color">
                    {{ `fas fa-${p.icon}` }}
                  </v-icon>
                </v-col>
              </v-row>

              <v-row justify="center" class="mx-auto mt-10">
                <span class="price" v-if="id == 3">{{ s.priceS }} €</span>
                <span class="price" v-else>{{ s.priceC }} €</span>
              </v-row>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>

      <v-row justify="center">
        <visibility :dados="subscriptionType" @clicked="register" />
      </v-row>
    </v-item-group>
  </v-container>
</template>

<script>
import axios from "axios";
export default {
  components: { Visibility: () => import("@/components/dialogs/Visibility") },
  name: "Ads",
  props: ["id", "dados"],
  data() {
    return {
      subscriptionType: { subscription: 0, type: this.id, price: 0 },
      styleObject: { border: "1px solid #78C4D4" },
      sub: [
        {
          id: 1,
          name: "Subscrição Mensal",
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
          priceS: "4.99",
          priceC: "7.99",
        },
        {
          id: 3,
          name: "Subscrição Trimestral",
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
          priceS: "11.99",
          priceC: "17.99",
        },
        {
          id: 6,
          name: "Subscrição Semestral",
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
          priceS: "19.99",
          priceC: "29.99",
        },
      ],
      visibility: 0,
    };
  },
  methods: {
    subscribe(s) {
      this.subscriptionType.subscription = s.id;
      if (this.id == 3) this.subscriptionType.price = s.priceS;
      else this.subscriptionType.price = s.priceC;
    },
    register: async function (n) {
      this.visibility = n;
      try {
        await axios.post("http://localhost:9040/subscription",{

        })
      } catch (e){
        console.log(e)
      }
    },
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
  font-size: 20px;
}

.card:hover {
  background-color: #c0e4ec;
}
</style>