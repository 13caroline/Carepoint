<template>
  <div>
    <v-container>
      <v-row align="center">
        <v-col>
          <div class="text-center">
            <div class="my-2" v-for="p in options" :key="p.name">
              <v-btn
                outlined
                color="#78C4D4"
                depressed
                class="rounded-lg button"
                width="30vw"
                large
                @click="register(p.route)"
              >
                {{ p.name }}
              </v-btn>
            </div>
          </div>
        </v-col>
      </v-row>

      <v-row align="center">
        <v-col>
          <v-img
            class="rounded-xl"
            center
            src="@/assets/usertype.jpg"
            max-height="250"
            contain
          >
          </v-img>
        </v-col>
        <v-col>
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
        { name: "Prestador de Serviços Individual", route:"/register/provider/solo" },
        { name: "Prestador de Serviços Coletivo", route:"/register/provider/collective" },
        { name: "Consumidor", route:"/register/consumer" },
      ],
    };
  },
  methods: {
    register(route) {
      this.$router.push(route);
    }
  }
};
</script>

<style scoped>
.button:hover {
  background-color: #78c4d4;
  color: white !important;
}
</style>
