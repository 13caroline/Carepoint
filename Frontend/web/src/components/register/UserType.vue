<template>
  <div>
    <v-container>
      <v-row align="center">
        <v-col>
          <div class="text-center">
            <h3 class="font-weight-regular text-uppercase pb-10">
              Inscrever-se na Carepoint
            </h3>
            <v-row
              class="my-2"
              justify="center"
              v-for="p in options"
              :key="p.name"
            >
              <v-col cols="9" md="6" sm="7">
                <v-btn
                  block
                  outlined
                  color="#78C4D4"
                  depressed
                  class="rounded-lg button"
                  large
                  @click="register(p.route)"
                >
                  {{ p.name }}
                </v-btn>
              </v-col>
            </v-row>
          </div>
        </v-col>
      </v-row>

      <v-row align="center">
        <v-col cols="12" md="6">
          <v-img
            class="rounded-xl"
            center
            src="@/assets/usertype.jpg"
            max-height="220"
            contain
          >
          </v-img>
        </v-col>
        <v-col cols="12" md = "6">
          <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
            ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
            aliquip ex ea commodo consequat.
          </p>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "UserType",
  data() {
    return {
      options: [
        { 
          name: "Prestador Individual",
          route: "/register/provider/solo",
        },
        {
          name: "Prestador Coletivo",
          route: "/register/provider/collective",
        },
        { name: "Consumidor", route: "/register/consumer" },
      ],
    };
  },
  methods: {
    register(route) {
      this.$router.push(route);
    },
  },
};
</script>

<style scoped>
.button:hover {
  background-color: #78c4d4;
  color: white !important;
}

h3 {
  color: #78c4d4;
}
</style>
