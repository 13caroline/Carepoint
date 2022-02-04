<template>
  <v-container>
    <v-row>
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
      :items="slots"
      class="elevation-1"
      :search="search"
      :page.sync="page"
      :items-per-page="itemsPerPage"
      hide-default-footer
      item-key="date_requested"
      @page-count="pageCount = $event"
      no-data-text="Não existem horários requisitados."
      no-results-text="Não foram encontrados resultados."
    >
      <template v-slot:[`item.date_requested`]="{ item }">
        {{ formatDate(item.date_requested) }}
      </template>

      <template v-slot:[`item.actions`]="{ item }">
        <v-tooltip top>
          <template v-slot:activator="{ on, attrs }">
            <v-icon
              v-bind="attrs"
              v-on="on"
              color="#AED581"
              class="mr-2"
              @click="editItem(item, 1)"
              small
            >
              fas fa-check
            </v-icon>
          </template>
          <span>Confirmar pedido</span>
        </v-tooltip>

        <v-tooltip top>
          <template v-slot:activator="{ on, attrs }">
            <v-icon
              v-bind="attrs"
              v-on="on"
              color="#EF9A9A"
              class="mr-2"
              @click="editItem(item, 0)"
              small
            >
              fas fa-times
            </v-icon>
          </template>
          <span>Recusar pedido</span>
        </v-tooltip>
      </template>

      <template v-slot:[`item.array_categories`]="{ item }">
        <v-tooltip top v-for="i in item.array_categories" :key="i">
          <template v-slot:activator="{ on, attrs }">
            <v-chip
              small
              v-bind="attrs"
              v-on="on"
              :color="getColor(i)"
              class="mr-1"
            >
              <v-icon x-small>{{ getIcon(i) }}</v-icon>
            </v-chip>
          </template>
          <span>{{ i }}</span>
        </v-tooltip>
      </template>
    </v-data-table>

    <v-pagination
      v-if="slots.length"
      v-model="page"
      :length="pageCount"
      circle
      :total-visible="7"
      color="#78C4D4"
      class="custom mt-2"
    ></v-pagination>
  </v-container>
</template>

<script>
import moment from "moment";
import axios from "axios";
import store from "@/store/index.js";
export default {
  data: () => ({
    slots: [],
    search: "",
    headers: [
      {
        text: "Data início",
        align: "start",
        value: "date_begin",
      },
      { text: "Data término", value: "date_end" },
      { text: "Data pedido", value: "date_requested" },
      { text: "Categorias", value: "array_categories", align: "center" },
      { text: "Cliente", value: "name" },
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
    editItem: async function (item, action) {
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

        this.editedIndex = this.slots.indexOf(item);
        this.editedItem = Object.assign({}, item);
        this.slots.splice(this.editedIndex, 1);
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
    },
  },
  created: async function () {
    try {
      let response = await axios.post(
        "http://localhost:9040/serviceProvider/requests",
        {
          token: store.getters.token,
        }
      );
      if (response) {
        this.slots = response.data.slots;
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