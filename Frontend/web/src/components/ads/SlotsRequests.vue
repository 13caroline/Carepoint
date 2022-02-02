<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="slots"
      class="elevation-1"
      :page.sync="page"
      :items-per-page="itemsPerPage"
      hide-default-footer
      @page-count="pageCount = $event"
      no-data-text="Não existem horários requisitados."
      no-results-text="Não foram encontrados resultados."
    >
      <template v-slot:[`item.j1.date_requested`]="{ item }">
        {{ formatDate(item.j1.date_requested) }}
      </template>

      <template v-slot:[`item.actions`]="{ item }">
        <v-icon color="#AED581" class="mr-2" @click="editItem(item, 1)" small>
          fas fa-check
        </v-icon>

        <v-icon color="#EF9A9A" class="mr-2" @click="editItem(item, 0)" small>
          fas fa-times
        </v-icon>
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
    headers: [
      {
        text: "Data início",
        align: "start",
        sortable: false,
        value: "j1.date_begin",
      },
      { text: "Data término", value: "j1.date_end" },
      { text: "Data pedido", value: "j1.date_requested" },
      { text: "Categorias", value: "" },
      { text: "Cliente", value: "name" },
      { text: "Ações", value: "actions", sortable: false },
    ],
    page: 1,
    pageCount: 0,
    itemsPerPage: 10,
  }),
  methods: {
    formatDate(d) {
      return moment(d).locale("pt").format("YYYY-MM-DD HH:MM");
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