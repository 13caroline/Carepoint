<template>
  <div>
    <Bar />
    <v-container>
      <v-row>
        <v-col cols="auto">
          <div>
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <v-icon
                  small
                  class="icon"
                  v-bind="attrs"
                  v-on="on"
                  @click="openGrid()"
                  >fas fa-grip-vertical</v-icon
                >
              </template>

              <span>Vista normal</span>
            </v-tooltip>

            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <v-icon
                  small
                  class="ml-3 icon"
                  v-bind="attrs"
                  v-on="on"
                  @click="openTable()"
                  >fas fa-table</v-icon
                >
              </template>

              <span>Vista compacta</span>
            </v-tooltip>
          </div>
        </v-col>
        <v-col cols="auto" class="ml-auto">
          <v-btn
            class="body-2 rounded-xl button"
            small
            color="#78C4D4"
            outlined
            dark
            to="/post/ad"
          >
            Publicar anúncio
            <v-icon small class="ml-2">fas fa-plus</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <div v-if="viewType == false">
        <v-data-iterator
          v-if="ads.length"
          :items="ads"
          :items-per-page.sync="itemsPerPage"
          :page.sync="page"
          hide-default-footer
          @page-count="pageCount == $event"
          no-data-text="Não existem anúncios publicados."
          no-results-text="Não foram encontrados resultados."
        >
          <template v-slot:default="props">
            <v-row>
              <v-col
                cols="auto"
                lg="6"
                md="6"
                class="mx-auto mx-sm-0"
                v-for="(a, index) in props.items"
                :key="index"
              >
                <v-card class="h-100 mt-0" outlined>
                  <v-card-text>
                    <v-row>
                      <v-col class="pb-0" align="right" cols="">
                        <span class="text-uppercase">Data</span>
                      </v-col>
                      <v-col class="pl-0 pb-0" cols="7">
                        <span class="black--text">
                          <strong>
                            {{ a.beginDate }} até {{ a.endDate }}
                          </strong>
                        </span>
                      </v-col>

                      <v-col class="pb-0" align="right" cols="5">
                        <span class="text-uppercase">Categoria</span>
                      </v-col>
                      <v-col class="pl-0 pb-0" cols="7">
                        <span class="black--text">
                          <strong> {{ a.categoryName }} </strong>
                        </span>
                        <br />
                        <span> Apoio a idosos </span>
                      </v-col>

                      <v-col class="pb-0" align="right" cols="5">
                        <span class="text-uppercase">Localização</span>
                      </v-col>
                      <v-col class="pl-0 pb-0" cols="7">
                        <span class="black--text">
                          <strong>{{ a.locationName }}</strong>
                        </span>
                      </v-col>

                      <v-col class="pb-0" align="right" cols="5">
                        <span class="text-uppercase">Valor</span>
                      </v-col>
                      <v-col class="pl-0 pb-0" cols="7">
                        <span class="black--text" v-if="a.price">
                          <strong>{{ a.price }} €/hora</strong>
                        </span>
                        <span class="black--text" v-else>
                          <strong>Preço negociável</strong>
                        </span>
                      </v-col>

                      <v-col class="pb-0" align="right" cols="5">
                        <span class="text-uppercase">estado</span>
                      </v-col>
                      <v-col class="pl-0 pb-0" cols="7">
                        <v-chip :color="estado(a.done)" small>
                          {{ getState(a.done) }}
                        </v-chip>
                      </v-col>
                    </v-row>
                  </v-card-text>
                  <v-divider class="mt-3"></v-divider>
                  <v-card-actions>
                    <v-spacer></v-spacer>

                    <v-tooltip top>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn icon @click="openDialog(a)">
                          <v-icon
                            color="#80CBC4"
                            dark
                            v-bind="attrs"
                            small
                            v-on="on"
                          >
                            fas fa-redo
                          </v-icon>
                        </v-btn>
                      </template>
                      <span>Republicar anúncio</span>
                    </v-tooltip>

                    <v-tooltip top>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn
                          icon
                          @click="conclude(a.idJobOffer)"
                          :disabled="a.done == 1"
                        >
                          <v-icon
                            color="#AED581"
                            dark
                            v-bind="attrs"
                            small
                            v-on="on"
                          >
                            fas fa-check
                          </v-icon>
                        </v-btn>
                      </template>
                      <span>Concluir</span>
                    </v-tooltip>

                    <v-tooltip top>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn
                          v-bind="attrs"
                          v-on="on"
                          icon
                          @click="show = !show"
                        >
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
          </template>
        </v-data-iterator>
        <small v-else> <em> não existem anúncios publicados </em></small>

        <v-row class="mt-4" align="center" justify="center" v-if="ads.length">
          <v-btn
            fab
            dark
            x-small
            depressed
            color="#78C4D4"
            class="mr-1"
            @click="formerPage"
          >
            <v-icon>mdi-chevron-left</v-icon>
          </v-btn>
          <v-btn
            fab
            dark
            x-small
            depressed
            color="#78C4D4"
            class="ml-1"
            @click="nextPage"
          >
            <v-icon>mdi-chevron-right</v-icon>
          </v-btn>
        </v-row>

        <v-row class="mt-5" align="center" justify="center" v-if="ads.length">
          <span class="grey--text"
            >Página {{ page }} de {{ numberOfPages }}</span
          >
        </v-row>
        <v-dialog v-model="dialog" width="100%" max-width="500" persistent>
          <v-card class="rounded-lg">
            <v-card-title class="font-weight-bold pt-6">
              Repetir anúncio de trabalho
            </v-card-title>

            <v-card-text class="my-2">
              <v-form ref="form" v-model="valid">
                <v-row>
                  <v-col class="pb-0" align="right" cols="5">
                    <span class="text-uppercase">Categoria</span>
                  </v-col>
                  <v-col class="pl-0 pb-0" cols="7">
                    <span class="black--text">
                      <strong> {{ dialogData.categoryName }} </strong>
                    </span>
                    <br />
                    <span> Apoio a idosos </span>
                  </v-col>

                  <v-col class="pb-0" align="right" cols="5">
                    <span class="text-uppercase">Localização</span>
                  </v-col>
                  <v-col class="pl-0 pb-0" cols="7">
                    <span class="black--text">
                      <strong>{{ dialogData.locationName }}</strong>
                    </span>
                  </v-col>

                  <v-col align="right" cols="5">
                    <span class="text-uppercase">Valor</span>
                  </v-col>
                  <v-col class="pl-0" cols="7">
                    <span class="black--text">
                      <strong>{{ dialogData.price }} €/hora</strong>
                    </span>
                  </v-col>
                </v-row>

                <div class="mt-2">
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
                        v-model="dateBegin"
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
                      v-model="dateBegin"
                      color="#78c4d4"
                      @input="menu = false"
                      locale="pt PT"
                      :min="new Date().toISOString().substr(0, 10)"
                    ></v-date-picker>
                  </v-menu>
                </div>
                <div>
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
                        v-model="dateEnd"
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
                      v-model="dateEnd"
                      color="#78c4d4"
                      @input="menu2 = false"
                      locale="pt PT"
                      :min="new Date().toISOString().substr(0, 10)"
                    ></v-date-picker>
                  </v-menu>
                </div>
                <v-row align="end" justify="end">
                  <v-col cols="auto">
                    <span> Valor a pagar: <strong> 1.99€ </strong> </span>
                  </v-col>
                </v-row>
              </v-form>
            </v-card-text>

            <v-divider></v-divider>

            <v-card-actions>
              <v-row align="end" justify="end">
                <v-col cols="auto">
                  <Cancel :dialogs="cancelar" @clicked="close()"></Cancel>
                </v-col>
                <v-col cols="auto" class="pl-0">
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
            </v-card-actions>
          </v-card>
        </v-dialog>
      </div>
      <div v-else>
        <Table />
      </div>
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
      viewType: false,
      dateBegin: "",
      dateEnd: "",
      menu: false,
      menu2: false,
      valid: false,
      dialog: false,
      dialogData: {},
      show: false,
      ads: [],
      pageCount: 0,
      page: 1,
      itemsPerPage: 6,
      total: 0,
      cancelar: {
        text: "a publicação de um anúncio",
        title: "publicação de um anúncio",
      },
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
    Cancel: () => import("@/components/dialogs/Cancel"),
    TopButton: () => import("@/components/global/TopButton"),
    Table: () => import("@/components/advertisements/Table"),
  },

  methods: {
    openGrid() {
      this.viewType = false;
      this.update;
    },
    openTable() {
      this.viewType = true;
      this.update();
    },
    getState(done) {
      if (done == 1) return "Não ativo";
      else return "Ativo";
    },
    estado(item) {
      if (item == 0) return "#C5E1A5";
      else return "#EF9A9A";
    },
    nextPage() {
      if (this.page + 1 <= this.numberOfPages) this.page += 1;
      this.getData();
    },
    formerPage() {
      if (this.page - 1 >= 1) this.page -= 1;
      this.getData();
    },
    openDialog(a) {
      this.dialog = true;
      this.dialogData = a;
    },
    close() {
      this.dialog = false;
    },
    update: async function () {
      this.ads = [];
      try {
        let response = await axios.post("http://localhost:9040/joboffer/own", {
          token: store.getters.token,
        });
        this.ads = response.data;
        this.total = this.ads.length;
      } catch (e) {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Ocorreu um erro. Por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
    conclude: async function (id) {
      try {
        await axios.put("http://localhost:9040/joboffer/conclude", {
          token: store.getters.token,
          id_job_offer: id,
        });
        this.update();
      } catch (e) {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Ocorreu um erro. Por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
    postAd: async function () {
      if (this.$refs.form.validate()) {
        console.log(this.dialogData);
        try {
          await axios.post("http://localhost:9040/joboffer/new", {
            token: store.getters.token,
            price: this.dialogData.price,
            description: this.dialogData.description,
            beginDate: this.dateBegin,
            endDate: this.dateEnd,
            idCategory: this.dialogData.idCategory,
            idLocation: this.dialogData.idLocation,
          });
          this.dialog = false;
          this.$snackbar.showMessage({
            show: true,
            color: "success",
            text: "Anúncio publicado",
            snackbar: true,
            timeout: 4000,
          });
          this.update();
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
    this.update();
  },
  computed: {
    numberOfPages() {
      return Math.ceil(this.total / this.itemsPerPage);
    },
  },
};
</script>

<style scoped>
.icon:hover {
  background-color: #ccc;
  cursor: pointer;
}
</style>
