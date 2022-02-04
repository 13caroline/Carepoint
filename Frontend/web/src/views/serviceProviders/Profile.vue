<template>
  <div>
    <Bar />
    <v-container>
      <v-tabs
        class="mt-2"
        v-model="tab"
        grow
        color="#78C4D4"
        background-color="#fafafa"
        show-arrows
      >
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
          <schedules></schedules>
        </v-tab-item>

        <v-tab-item>
          <slots-requests></slots-requests>
        </v-tab-item>
      </v-tabs-items>
    </v-container>
    <top-button />
    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {
      tab: null,
      items: [
        { tab: "Dados de utilizador" },
        { tab: "Subscrição" },
        { tab: "Horários" },
        { tab: "Requisição de horários" },
      ],
      user: {},
      categories: {},
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
    personalData: () => import("@/components/serviceProvider/PersonalData.vue"),
    subscriptionData: () =>
      import("@/components/serviceProvider/Subscription.vue"),
    TopButton: () => import("@/components/global/TopButton"),
    schedules: () => import("@/components/serviceProvider/Schedules.vue"),
    SlotsRequests: () => import("@/components/ads/SlotsRequests.vue"),
  },

  methods: {
    onPick() {
      this.$refs.fileInput.click();
    },
  },
};
</script>


