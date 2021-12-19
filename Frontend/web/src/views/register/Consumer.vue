<template>
  <div id="userTypePage">
    <app-bar />

    <Consumer />

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
    Consumer: () => import("@/components/register/ConsumerForm"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>