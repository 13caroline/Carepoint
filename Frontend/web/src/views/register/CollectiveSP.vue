<template>
  <div id="userTypePage">
    <app-bar />

    <CollectiveSP />

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
    CollectiveSP: () => import("@/components/register/CollectiveSPForm"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>