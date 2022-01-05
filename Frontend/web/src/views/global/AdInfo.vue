<template>
  <div>
    <app-bar-account />
    <ad-info :id="$route.params.id"/>
    <Foot />
  </div>
</template>

<script>
export default {
  data: () => ({
    
  }),
  
  components: {
    AppBarAccount: () => import("@/components/global/AppBarAccount"),
    AdInfo: () => import("@/components/global/AdInfo"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>
