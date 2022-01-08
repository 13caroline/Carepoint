<template>
  <div>
    <Bar />
    <v-container>
     
      <v-tabs v-model="tab" color="#2596be" background-color="#fafafa">
        <v-tab v-for="item in items" :key="item.tab">
          {{ item.tab }}
        </v-tab>
      </v-tabs>

      <v-tabs-items v-model="tab">
        <v-tab-item>
          <!--<Dados :animal="dados"></Dados>-->
        </v-tab-item>

        <v-tab-item>
          <personalData :user="user"></personalData>
        </v-tab-item>

        <v-tab-item>
          <!--<Consultas :animal="dados"></Consultas>-->
          <p> cenas3 </p>
        </v-tab-item>

        <v-tab-item>
          <!--<Cirurgia :animal="dados"></Cirurgia>-->
          <p> cenas4 </p>
        </v-tab-item>

        <v-tab-item>
          <!--<Historico :animal="dados"></Historico> -->
          <p> cenas5 </p>
        </v-tab-item>
      </v-tabs-items>
    </v-container>
    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
export default {
    
  data() {
    return {
      items: [{ tab: "Dados Pessoais" }, { tab: "Subscription" }, { tab: "item3" }],
      user: {},
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    //ImageUpload: () => import("@/components/dialogs/ImageUpload"),
    Foot: () => import("@/components/global/Footer"),
    personalData: () => import("@/components/serviceProvider/PersonalData.vue")
  },

  methods: {
    onPick() {
      this.$refs.fileInput.click();
    },
  },
  created: async function () {
    try {
      let response = await axios.post(
        "http://localhost:9040/users/perfil",
        {
          token: store.getters.token,
        }
      );
      console.log(response.data);
      this.user = response.data.perfil[0];
    } catch (e) {
      this.$snackbar.showMessage({
        show: true,
        color: "error",
        text: "Ocorreu um erro. Por favor tente mais tarde!",
        timeout: 4000,
      });
    }
  },
};
</script>


<style scoped>
.infos {
  text-align: start;
}
.respos {
  text-align: end;
  font-weight: bold;
}
.body-2 {
  font-size: 0.8rem !important;
}
.head {
  font-size: 2.75rem !important;
}
.font-weight-bold {
  font-size: 15px;
}
.font-weight-regular {
  font-size: 14px;
}
.font-weight-bold.col-sm-12.col-md-auto.col-auto {
  padding-bottom: 0;
}
.row.col.col-6 {
  margin-top: 0;
}
.foto {
  width: 170px;
}
.group {
  color: #282424;
  font-size: 20px;
}
.button:hover {
  background-color: #78c4d4;
  color: white !important;
}
</style>