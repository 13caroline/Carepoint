<template>
  <div id="home">
    <AppBar />

    <about />

    <care-providers />

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
    About: () => import("@/components/page/About"),
    CareProviders: () => import("@/components/page/CareProviders")
  },
};
</script>
