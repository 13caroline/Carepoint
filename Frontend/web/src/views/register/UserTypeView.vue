<template>
  <div id="userTypePage">
    <app-bar />

    <user-type />

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
    UserType: () => import("@/components/register/UserType"),
    Foot: () => import("@/components/global/Footer")
  },
};
</script>