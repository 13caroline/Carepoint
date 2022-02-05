<template>
  <v-container>
    <v-item-group>
      <v-row justify="center" class="mt-5">
        <v-col cols="auto" class="mx-auto mx-sm-0">
          <v-card
            class="card rounded-xl overflow-auto"
            outlined
            tile
            :style="styleObject"
            height="400"
            @click="subscribe(exp)"
          >
            <v-card-title class="ma-5 mb-10 mb-sm-10 mb-md-10 mb-lg-10">
              <v-row justify="center">
                {{ exp.name }}
              </v-row>
            </v-card-title>

            <v-card-text>
              <v-row
                justify="center"
                class="mx-auto ml-sm-0 ml-md-0 ml-lg-6"
                v-for="(p, index) in exp.pros"
                :key="index"
              >
                <v-col cols="10" md="9" sm="7">
                  <span>
                    {{ p.title }}
                  </span>
                </v-col>

                <v-col cols="2" md="3" sm="2">
                  <v-icon smal :color="p.color">
                    {{ `fas fa-${p.icon}` }}
                  </v-icon>
                </v-col>
              </v-row>

              <v-row justify="center" class="mx-auto mt-10">
                <span class="price">{{ exp.priceS }} €</span>
              </v-row>
            </v-card-text>
          </v-card>
        </v-col>
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
            <v-card-title class="ma-5 mb-10 mb-sm-10 mb-md-10 mb-lg-10">
              <v-row justify="center">
                {{ s.name }}
              </v-row>
            </v-card-title>

            <v-card-text>
              <v-row
                justify="center"
                class="mx-auto ml-sm-0 ml-md-0 ml-lg-6"
                v-for="(p, index) in s.pros"
                :key="index"
              >
                <v-col cols="10" md="9" sm="7">
                  <span>
                    {{ p.title }}
                  </span>
                </v-col>

                <v-col cols="2" md="3" sm="2">
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
        <v-btn
          dense
          color="#78c4d4"
          class="rounded-lg mr-4"
          depressed
          outlined
          @click="back()"
        >
          Retroceder
        </v-btn>
        <visibility :dados="subscriptionType" />
      </v-row>
    </v-item-group>
  </v-container>
</template>

<script>
export default {
  components: { Visibility: () => import("@/components/dialogs/Visibility") },
  name: "Ads",
  props: ["id", "dados"],
  data() {
    return {
      subscriptionType: {
        subscription: 5,
        type: this.id,
        price: 0,
        updated: 0,
      },
      styleObject: { border: "1px solid #78C4D4" },
      exp: {
        id: 0,
        name: "Período Experimental",
        pros: [
          { title: "Publicar anúncios", icon: "times", color: "#EF9A9A" },
          { title: "Adicionar agenda", icon: "times", color: "#EF9A9A" },
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
        priceS: "0.00",
        priceC: "0.00",
      },
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
      this.id == 3
        ? (this.subscriptionType.price = s.priceS)
        : (this.subscriptionType.price = s.priceC);
    },
    back() {
      this.$router.back();
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