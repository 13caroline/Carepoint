<template>
  <v-data-table
    :headers="adsHeaders"
    :items="ads"
    :items-per-page="5"
    class="elevation-1"
  >
  </v-data-table>
</template>


<script>
import axios from "axios";
import store from "@/store/index.js";
  export default {
    data () {
      return {
        expanded: [],
        adsHeaders: [
          {
            text: 'Data início',
            align: 'start',
            sortable: false,
            value: 'beginDate',
          },
          { text: 'Data fim', value: 'endDate' },
          { text: 'Categoria', value: 'categoryName' },
          { text: 'Localização', value: 'locationName' },
          { text: 'Valor', value: 'price' },
          { text: 'Estado', value: 'done' },
          { text: '', value: 'data-table-expand' },
        ],
        desserts: [
          {
            name: 'Frozen Yogurt',
            calories: 159,
            fat: 6.0,
            carbs: 24,
            protein: 4.0,
            iron: '1%',
          },
          {
            name: 'Ice cream sandwich',
            calories: 237,
            fat: 9.0,
            carbs: 37,
            protein: 4.3,
            iron: '1%',
          },
          {
            name: 'Eclair',
            calories: 262,
            fat: 16.0,
            carbs: 23,
            protein: 6.0,
            iron: '7%',
          },
          {
            name: 'Cupcake',
            calories: 305,
            fat: 3.7,
            carbs: 67,
            protein: 4.3,
            iron: '8%',
          },
          {
            name: 'Gingerbread',
            calories: 356,
            fat: 16.0,
            carbs: 49,
            protein: 3.9,
            iron: '16%',
          },
          {
            name: 'Jelly bean',
            calories: 375,
            fat: 0.0,
            carbs: 94,
            protein: 0.0,
            iron: '0%',
          },
          {
            name: 'Lollipop',
            calories: 392,
            fat: 0.2,
            carbs: 98,
            protein: 0,
            iron: '2%',
          },
          {
            name: 'Honeycomb',
            calories: 408,
            fat: 3.2,
            carbs: 87,
            protein: 6.5,
            iron: '45%',
          },
          {
            name: 'Donut',
            calories: 452,
            fat: 25.0,
            carbs: 51,
            protein: 4.9,
            iron: '22%',
          },
          {
            name: 'KitKat',
            calories: 518,
            fat: 26.0,
            carbs: 65,
            protein: 7,
            iron: '6%',
          },
        ],
      }
    },
    methods: {
      update: async function () {
      this.ads = [];
      try {
        let response = await axios.post("http://localhost:9040/joboffer/own", {
          token: store.getters.token,
        });
        this.ads = response.data;
        console.log(this.ads)
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
    },
    created: async function () {
      console.log("fa")
    this.update();
  },
  }
</script>

<!--
<script>

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
      itemsPerPage: 9,
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

  computed: {
    numberOfPages() {
      return Math.ceil(this.total / this.itemsPerPage);
    },
  },
};
</script>
-->