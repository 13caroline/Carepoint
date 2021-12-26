<template>
  <div id="home">
    <AppBar />

    <login />

    <about />

    <care-providers />

    <top-button />

    <Foot />
  </div>
</template>

<script>
export default {
  name: "HomePage",

  data: () => ({}),

  components: {
    AppBar: () => import("@/components/page/AppBar"),
    Foot: () => import("@/components/global/Footer"),
    Login: () => import("@/components/page/Login"),
    About: () => import("@/components/page/About"),
    CareProviders: () => import("@/components/page/CareProviders"),
    TopButton: () => import("@/components/global/TopButton")
  },
};
</script>
