<template>
  <v-app>
    <v-main>
      <router-view></router-view>
      <Snackbar />
    </v-main>
  </v-app>
</template>

<script>
  export default {
    name : 'App', 
    components: {
      Snackbar: () => import ("@/components/global/Snackbar.vue")
    },
    data: () => ({
  }),
  }
</script> 