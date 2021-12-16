<template>
  <div>
    <v-app-bar flat color="#FFFFFF" height="180">
      <v-row justify="center" class="w-100">
        <v-col cols="7" md="4" offset-md="4">
          <v-img src="@/assets/logo.png" max-height="270" max-width="270">
          </v-img>
        </v-col>
        <v-col cols="5" md="2">
          <v-btn outlined color="#78C4D4" depressed class="rounded-xl">
            Iniciar Sessão
          </v-btn>
        </v-col>
      </v-row>
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