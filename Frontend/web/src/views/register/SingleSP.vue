<template>
  <div id="userTypePage">
    <app-bar />

    <SingleSP />

    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  components: {
    AppBar: () => import("@/components/register/AppBar"),
    SingleSP: () => import("@/components/register/SingleSPForm"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>