<template>
  <div>
    <Bar />
    <v-container>
     
      <v-tabs v-model="tab" grow color="#2596be" background-color="#fafafa" show-arrows>
        <v-tab v-for="item in items" :key="item.tab">
          {{ item.tab }}
        </v-tab>
      </v-tabs>

      <v-tabs-items v-model="tab">
        <v-tab-item>
           <personalData :user="user" :categories="categories"></personalData>
        </v-tab-item>

        <v-tab-item>
           <subscriptionData :user="user"></subscriptionData>
        </v-tab-item>

      </v-tabs-items>
    </v-container>
    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
//import moment from "moment";
export default {
    
  data() {
    return {
      tab: null,
      items: [{ tab: "Dados de utilizador" }, { tab: "Subscrição" }, { tab: "Horários" }],
      user: {},
      categories: {},
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
    personalData: () => import("@/components/serviceProvider/PersonalData.vue"),
    subscriptionData: () => import("@/components/serviceProvider/Subscription.vue")
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
      console.log(store.getters.token)
      console.log(response.data);

      
      this.user = response.data.perfil[0];
      console.log("SUB:  " + this.user.subDuration[6])//(moment(this.user.subDuration, moment.ISO_8601).format("M")));
      this.categories = response.data.categories;
      if(this.user.sex=="M")this.user.sex ="Masculino"
      else if(this.user.sex=="F")this.user.sex ="Feminino"
      else this.user.sex = "Indefinido"
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


