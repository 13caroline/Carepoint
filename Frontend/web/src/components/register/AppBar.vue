<template>
  <div>
    <v-app-bar flat color="#FFFFFF" height="90">
      <v-spacer></v-spacer>
      <v-img src="@/assets/logo.png" max-height="270" max-width="270" class="mt-12"> </v-img>

      <v-spacer></v-spacer>

      <v-btn outlined color="#78C4D4" depressed class="rounded-xl">
        Iniciar Sessão
      </v-btn>
    </v-app-bar>
  </div>
</template>

<script>
export default {
  name: "appbar",
  data() {
    return {};
  },
};
</script>