<template>
  <div id="userTypePage">
    <app-bar />

    <user-type />
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
  },
};
</script>