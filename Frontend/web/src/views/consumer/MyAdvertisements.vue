<template>
  <div>
    <Bar />
    <v-container>
      <v-row>
          <v-col cols="auto" class="ml-auto">
            <v-btn
              class="body-2 rounded-xl button"
              small
              color="#78C4D4"
              outlined
              dark
              to="/consumer/post/ad"
            >
              Publicar anúncio
              <v-icon small class="ml-2">fas fa-plus</v-icon>
            </v-btn>
          </v-col>
      </v-row>
      <v-row>
        <v-col
          cols="auto"
          lg="6"
          md="6"
          class="mx-auto mx-sm-0"
          v-for="(a, index) in ads"
          :key="index"
        >
          <v-card class="h-100 mt-5" outlined>
            <v-card-text>
              <v-row>
                <v-col class="pb-0" align="right" cols="">
                  <span class="text-uppercase">Data</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong> {{ a.beginDate }} - {{ a.endDate }} </strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Categoria</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong> {{ a.category }} </strong>
                  </span>
                  <br />
                  <span> {{ a.area }} </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Localização</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ a.location }}</strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Valor</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ a.value }} €/hora</strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">estado</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <v-chip :color="estado(a.state)" small>
                    {{ a.state }}
                  </v-chip>
                </v-col>
              </v-row>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>

              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-icon color="#66BB6A" dark v-bind="attrs" v-on="on">
                    mdi-calendar-check
                  </v-icon>
                </template>
                <span>Concluir</span>
              </v-tooltip>

              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn v-bind="attrs" v-on="on" icon @click="show = !show">
                    <v-icon>{{
                      show ? "mdi-chevron-up" : "mdi-chevron-down"
                    }}</v-icon>
                  </v-btn>
                </template>
                <span>Ver descrição</span>
              </v-tooltip>
            </v-card-actions>
            <v-expand-transition>
              <div v-show="show">
                <v-divider></v-divider>

                <v-card-text>
                  {{ a.description }}
                </v-card-text>
              </div>
            </v-expand-transition>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {
      show: false,
      ads: [
        {
          beginDate: "12/03/2021",
          endDate: "13/03/2021",
          location: "Porto",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          value: 30,
          area: "Apoio a idosos",
          category: "Higiene",
          state: "Não Ativo",
        },
        {
          beginDate: "12/03/2021",
          endDate: "13/03/2021",
          location: "Porto",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          value: 30,
          area: "Apoio a idosos",
          category: "Higiene",
          state: "Não Ativo",
        },
        {
          beginDate: "12/03/2021",
          endDate: "13/03/2021",
          location: "Porto",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          value: 30,
          area: "Apoio a idosos",
          category: "Higiene",
          state: "Não Ativo",
        },
        {
          beginDate: "12/03/2021",
          endDate: "13/03/2021",
          location: "Porto",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          value: 30,
          area: "Apoio a idosos",
          category: "Higiene",
          state: "Ativo",
        },
        {
          beginDate: "12/03/2021",
          endDate: "13/03/2021",
          location: "Porto",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          value: 30,
          area: "Apoio a idosos",
          category: "Higiene",
          state: "Ativo ",
        },
        {
          beginDate: "12/03/2021",
          endDate: "13/03/2021",
          location: "Porto",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          value: 30,
          area: "Apoio a idosos",
          category: "Higiene",
          state: "Ativo",
        },
      ],
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
  },

  methods: {
    estado(item) {
      if (item == "Ativo") return "#C5E1A5";
      else return "#EF9A9A";
    },
  },
};
</script>