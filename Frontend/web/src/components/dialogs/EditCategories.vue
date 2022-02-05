<template>
  <v-dialog v-model="dialog" width="100%" max-width="45%">
    <template v-slot:activator="{ diag, attrs }">
      <v-btn
        color="#78C4D4"
        class="mb-2"
        v-bind="attrs"
        v-on="{ ...diag }"
        small
        outlined
        rounded
        dark
        @click="dialog = true"
      >
        <v-icon small class="mr-2"> far fa-edit</v-icon> Editar categorias
      </v-btn>
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
                    <v-tooltip right>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn
                          color="#78C4D4"
                          small
                          v-bind="attrs"
                          v-on="{ ...on }"
                          dark
                          @click="dialog2 = true"
                        >
                          <v-icon small class="mr-2"> fas fa-plus</v-icon> Nova
                          categoria
                        </v-btn>
                      </template>
                      <span> Nova categoria </span>
                    </v-tooltip>
                  </v-col>
                  <v-spacer></v-spacer>
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
                    <v-chip small :color="getColor(item.name)" class="mr-1">
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
                          @click="editItem(item)"
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

        <v-dialog v-model="dialog2" max-width="500px">
          <v-card>
            <v-card-title>
              <span class="text-h5">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <div>
                  <span>Categorias *</span>
                  <v-select
                    v-if="formTitle == 'Nova categoria'"
                    outlined
                    flat
                    dense
                    v-model="editedItem.idCategory"
                    :items="cat"
                    item-value="idCategory"
                    item-text="name"
                    color="#78C4D4"
                    name="categories"
                    required
                  />

                  <v-text-field
                    v-else
                    disabled
                    outlined
                    flat
                    dense
                    :value="editedItem.idCategory"
                    v-model="editedItem.name"
                    color="#78C4D4"
                    name="categories"
                    required
                  />
                </div>
                <div>
                  <span>Preço</span>
                  <v-text-field
                    outlined
                    flat
                    dense
                    v-model="editedItem.price"
                    single-line
                    color="#78C4D4"
                    name="experience"
                    suffix="€/hora"
                  />
                </div>
              </v-container>
            </v-card-text>
            <v-card-actions>
              <v-row class="mb-0 py-0">
                <v-col cols="12" md="6">
                  <v-btn
                    depressed
                    large
                    outlined
                    dark
                    block
                    color="#78c4d4"
                    @click="close()"
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
                    @click="addItem()"
                  >
                    Confirmar
                  </v-btn>
                </v-col>
              </v-row>
            </v-card-actions>
          </v-card>
        </v-dialog>
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
      { text: "Categoria", align: "start", value: "name" },
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
    cat: [],
    editedIndex: -1,
    editedItem: {
      name: 0,
      price: "",
      idCategory: 0,
    },
    dialog: false,
    dialog2: false,
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
    remove: async function (item) {
      try {
        await axios.put("http://localhost:9040/serviceProvider/remCategoria", {
          token: store.getters.token,
          categoria: item.idCategory,
        });
        this.editedIndex = this.categories.indexOf(item);
        this.editedItem = Object.assign({}, item);
        this.categories.splice(this.editedIndex, 1);
        this.$snackbar.showMessage({
          show: true,
          text: "Categoria removida com sucesso.",
          color: "success",
          snackbar: true,
          timeout: 4000,
        });
      } catch (e) {
        console.log(e);
        this.$snackbar.showMessage({
          show: true,
          text: "Ocorreu um erro, por favor tente mais tarde!",
          color: "warning",
          snackbar: true,
          timeout: 4000,
        });
      }
    },
    close() {
      this.dialog2 = false;
      this.$nextTick(() => {
        this.editedItem = { name: 0, price: "", idCategory: 0 };
        this.editedIndex = -1;
      });
    },
    editItem: async function (item) {
      this.editedIndex = this.categories.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog2 = true;
    },

    addItem: async function () {
      try {
        let message = "";
        let url = "";
        this.formTitle == "Nova categoria"
          ? ((url = "http://localhost:9040/serviceProvider/addCategoria"),
            (message = "Categoria adicionada com sucesso."))
          : ((url = "http://localhost:9040/serviceProvider/updCategoria"),
            (message = "Categoria editada com sucesso"));

        await axios.put(url, {
          token: store.getters.token,
          categoria: this.editedItem.idCategory,
          price: this.editedItem.price,
        });
        this.editedIndex > -1
          ? Object.assign(this.categories[this.editedIndex], this.editedItem)
          : this.categories.push(this.editedItem);

        this.close();

        this.$snackbar.showMessage({
          show: true,
          color: "success",
          text: message,
          timeout: 4000,
        });
      } catch (error) {
        this.$snackbar.showMessage({
          show: true,
          color: "warning",
          text: "Ocorreu um erro, por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
  },
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "Nova categoria" : "Editar categoria";
    },
  },
  created: async function () {
    try {
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

    try {
      let response3 = await axios.get("http://localhost:9040/category");
      if (response3) {
        this.cat = response3.data;
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
         