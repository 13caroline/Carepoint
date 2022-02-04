<template>
  <v-dialog v-model="dialog" width="100%" max-width="45%" persistent>
    <template v-slot:activator="{ diag, attrs }">
      <v-tooltip top>
        <template v-slot:activator="{ on }">
          <v-btn
            color="#78C4D4"
            class="mb-2"
            v-bind="attrs"
            v-on="{ ...on, ...diag }"
            small
            fab
            dark
            @click="dialog = true"
          >
            <v-icon small> far fa-edit</v-icon>
          </v-btn>
        </template>
        <span class="caption">Editar categorias</span>
      </v-tooltip>
    </template>
    <v-card>
      <v-form ref="form" v-model="valid">
        <v-card-title class="font-weight-regular text-uppercase">
          Editar categorias
        </v-card-title>

        <v-card-text>
          <v-row align="center">
            <template>
              <v-container>
                <v-row justify="end">
                  <v-col cols="auto">
                    <v-text-field
                      v-model="search"
                      dense
                      append-icon="mdi-magnify"
                      label="Procurar"
                      single-line
                      hide-details
                      class="mb-4"
                      color="#78C4D4"
                    ></v-text-field>
                  </v-col>
                </v-row>
                <v-data-table
                  :headers="headers"
                  :items="categories"
                  class="elevation-1"
                  :search="search"
                  :page.sync="page"
                  :items-per-page="itemsPerPage"
                  hide-default-footer
                  @page-count="pageCount = $event"
                  no-data-text="Não existem categorias registadas."
                  no-results-text="Não foram encontrados resultados."
                >
                  <template v-slot:[`item.name`]="{ item }">
                    <v-chip
                      small
                      v-bind="attrs"
                      v-on="on"
                      :color="getColor(item.name)"
                      class="mr-1"
                    >
                      <v-icon x-small>{{ getIcon(item.name) }}</v-icon>
                    </v-chip>
                    <span>{{ item.name }}</span>
                  </template>

                  <template v-slot:[`item.actions`]="{ item }">
                    <v-tooltip top>
                      <template v-slot:activator="{ on, attrs }">
                        <v-icon
                          v-bind="attrs"
                          v-on="on"
                          color="#80CBC4"
                          class="mr-2"
                          @click="editItem(item, 1)"
                          small
                        >
                          fas fa-pen
                        </v-icon>
                      </template>
                      <span>Alterar categoria</span>
                    </v-tooltip>

                    <v-tooltip top>
                      <template v-slot:activator="{ on, attrs }">
                        <v-icon
                          v-bind="attrs"
                          v-on="on"
                          color="#EF9A9A"
                          class="mr-2"
                          @click="remove(item)"
                          small
                        >
                          fas fa-trash
                        </v-icon>
                      </template>
                      <span>Remover categoria</span>
                    </v-tooltip>
                  </template>
                </v-data-table>

                <v-pagination
                  v-if="categories.length"
                  v-model="page"
                  :length="pageCount"
                  circle
                  :total-visible="7"
                  color="#78C4D4"
                  class="custom mt-2"
                ></v-pagination>
              </v-container>
            </template>
          </v-row>
        </v-card-text>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import moment from "moment";
import axios from "axios";
import store from "@/store/index.js";
export default {
  data: () => ({
    categories: [],
    search: "",
    headers: [
      {
        text: "Categoria",
        align: "start",
        value: "name",
      },
      { text: "Preço (€/hora)", value: "price", align: "center" },
      { text: "Ações", value: "actions", sortable: false },
    ],
    page: 1,
    pageCount: 0,
    itemsPerPage: 7,
    category: [
      { name: "Apoio externo", icon: "fas fa-car-side", color: "#FDA172" },
      {
        name: "Cuidados de higiene e conforto pessoal",
        icon: "fas fa-pump-medical",
        color: "#95C8D8",
      },
      { name: "Cuidados de lazer", icon: "fas fa-book-open", color: "#C5E1A5" },
      { name: "Cuidados médicos", icon: "fas fa-pills", color: "#F5C3C2" },
      {
        name: "Fornecimento e apoio nas refeições",
        icon: "fas fa-utensils",
        color: "#EEDC82",
      },
      { name: "Higiene habitacional", icon: "fas fa-home", color: "#D7BFDC" },
    ],
    editedIndex: -1,
    editedItem: null,
    dialog: false,
    valid: false,
  }),
  methods: {
    formatDate(d) {
      return moment(d).locale("pt").format("DD-MM-YYYY HH:MM");
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
    /*remove: async function(item){
      try{
        await axios.put("http://localhost:9040/serviceProvider/remCategoria", {
          token: store.getters.token, 
          
        })
      }
    }*/
    /*editItem: async function (item, action) {
      try {
        let url = "";
        let message = "";
        action == 1
          ? ((url = "http://localhost:9040/serviceProvider/acceptSlot"),
            (message = "Slot aceite com sucesso."))
          : ((url = "http://localhost:9040/serviceProvider/remSlot"),
            (message = "Slot recusado com sucesso."));
        await axios.put(url, {
          token: store.getters.token,
          id: item.id,
          dateEnd: item.date_end,
          occupied: 0,
          dateBegin: item.date_begin,
          postDate: item.date_requested,
          categories: item.categories,
        });

        this.$snackbar.showMessage({
          show: true,
          text: message,
          color: "success",
          snackbar: true,
          timeout: 4000,
        });

        this.editedIndex = this.categories.indexOf(item);
        this.editedItem = Object.assign({}, item);
        this.categories.splice(this.editedIndex, 1);
      } catch (error) {
        let message = "";
        error.response.data.error == "Slot já preenchido com outro trabalho!"
          ? (message = "Este horário já se encontra preenchido.")
          : (message = "Ocorreu um erro, por favor tente mais tarde!");
        this.$snackbar.showMessage({
          show: true,
          color: "warning",
          text: message,
          timeout: 4000,
        });
      }
    },*/
  },
  created: async function () {
    try {
      console.log("jello");
      let response = await axios.post(
        "http://localhost:9040/serviceProvider/getCategorias",
        {
          token: store.getters.token,
        }
      );
      if (response) {
        this.categories = response.data.categories;
      }
    } catch (e) {
      console.log(e);
    }
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
         