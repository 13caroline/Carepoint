<template>
  <div>
    <Bar />
    <v-container>
     
      <v-tabs v-model="tab" grow color="#2596be" background-color="#fafafa">
        <v-tab v-for="item in items" :key="item.tab">
          {{ item.tab }}
        </v-tab>
      </v-tabs>

      <v-tabs-items v-model="tab">
        <v-tab-item>
           <personalData></personalData>
        </v-tab-item>

        <v-tab-item>
           <subscriptionData></subscriptionData>
        </v-tab-item>

        <v-tab-item>
          <!--<Consultas :animal="dados"></Consultas>-->
          <p> cenx  as3 </p>
        </v-tab-item>
      </v-tabs-items>
    </v-container>
    <Foot />
  </div>
</template>

<script>

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
};
</script>


