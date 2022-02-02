<template>
  <v-container>
    <v-data-table
      :page.sync="page"
      :items-per-page="itemsPerPage"
      hide-default-footer
      @page-count="pageCount = $event"
      :headers="adsHeaders"
      :items="ads"
      :expanded.sync="expanded"
      item-key="idJobOffer"
      show-expand
      class="elevation-1"
    >
      <template v-slot:expanded-item="{ headers, item }">
        <td :colspan="headers.length">
          {{ item.description }}
        </td>
      </template>
      <template v-slot:[`item.done`]="{ item }">
        <v-chip small :color="estado(item.done)">
          {{ getState(item.done) }}
        </v-chip>
      </template>

       <template v-slot:[`item.categoryName`]="{ item }">
        <v-chip small :color="getColor(item.categoryName)" class="mr-1">
          <v-icon x-small>{{ getIcon(item.categoryName) }}</v-icon>

        </v-chip>
        <span>{{item.categoryName}}</span>
      </template>

      <template v-slot:[`item.actions`]="{ item }">
        <v-tooltip top>
          <template v-slot:activator="{ on, attrs }">
            <v-icon
              color="#80CBC4"
              v-bind="attrs"
              v-on="on"
              dark
              small
              @click="openDialog(item)"
            >
              fas fa-redo
            </v-icon>
          </template>
          <span>Republicar anúncio</span>
        </v-tooltip>
        <v-tooltip top>
          <template v-slot:activator="{ on, attrs }">
            <v-icon
              class="ml-2"
              v-bind="attrs"
              v-on="on"
              color="#AED581"
              dark
              small
              @click="conclude(item.idJobOffer)"
            >
              fas fa-check
            </v-icon>
          </template>
          <span>Concluir</span>
        </v-tooltip>
      </template>
    </v-data-table>
    <v-pagination
      v-if="ads.length"
      v-model="page"
      :length="pageCount"
      circle
      :total-visible="7"
      color="#78C4D4"
      class="custom mt-2"
    ></v-pagination>
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
  </v-container>
</template>


<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
  data() {
    return {
      page: 1,
      pageCount: 0,
      itemsPerPage: 10,
      dialog: false,
      expanded: [],
      dialogData: {},
      dateBegin: "",
      dateEnd: "",
      menu: false,
      menu2: false,
      cancelar: {
        text: "a publicação de um anúncio",
        title: "publicação de um anúncio",
      },
      valid: false,
      adsHeaders: [
        {
          text: "Data início",
          align: "start",
          sortable: false,
          value: "beginDate",
        },
        { text: "Data término", value: "endDate" },
        { text: "Categoria", value: "categoryName" },
        { text: "Localização", value: "locationName" },
        { text: "Valor (€)", value: "price" },
        { text: "Estado", value: "done" },
        { text: "", value: "data-table-expand" },
        { text: "Actions", value: "actions", sortable: false },
      ],
      ads: [],
      category: [
        { name: "Apoio externo", icon: "fas fa-car-side", color: "#FDA172" },
        {
          name: "Cuidados de higiene e conforto pessoal",
          icon: "fas fa-pump-medical",
          color:"#95C8D8"
        },
        { name: "Cuidados de lazer", icon: "fas fa-book-open", color:"#C5E1A5" },
        { name: "Cuidados médicos", icon: "fas fa-pills", color:"#F5C3C2" },
        { name: "Fornecimento e apoio nas refeições", icon: "fas fa-utensils", color:"#EEDC82" },
        { name: "Higiene habitacional", icon: "fas fa-home", color:"#D7BFDC" },
      ],
    };
  },
  components: {
    Cancel: () => import("@/components/dialogs/Cancel"),
  },
  methods: {
    estado(item) {
      if (item == 0) return "#C5E1A5";
      else return "#EF9A9A";
    },
    getState(done) {
      if (done == 1) return "Não ativo";
      else return "Ativo";
    },
    getIcon(c) {
      var row = this.category.filter((obj) => {
        return obj.name === c;
      });
      return Object.values(row[0])[1];
    },
    getColor(c) {
      var row = this.category.filter((obj) => {
        return obj.name === c;
      });
    
      return Object.values(row[0])[2];
    },
    update: async function () {
      this.ads = [];
      try {
        let response = await axios.post("http://localhost:9040/joboffer/own", {
          token: store.getters.token,
        });
        this.ads = response.data;
        console.log(this.ads);
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
    openDialog(a) {
      this.dialog = true;
      this.dialogData = a;
    },
    close() {
      this.dialog = false;
    },
    postAd: async function () {
      if (this.$refs.form.validate()) {
        console.log(this.dialogData);
        try {
          await axios.post("http://localhost:9040/joboffer/new", {
            token: store.getters.token,
            price: this.dialogData.price,
            description: "DescTeste",
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
    console.log("fa");
    this.update();
  },
};
</script>

<style>
.custom {
  width: auto;
  margin-left: auto;
}
.custom .v-pagination__navigation {
  height: 26px !important;
  width: 26px !important;
}
.custom .v-pagination__navigation .v-icon {
  font-size: 16px !important;
}
.custom .v-pagination__item {
  height: 26px !important;
  min-width: 26px !important;
  font-size: 0.85rem !important;
}
</style>