<template>
  <div>
    <app-bar-account />
    <ad-info :id="$route.params.id"/>
    <top-button />
    <Foot />
  </div>
</template>

<script>
export default {
  data: () => ({
    
  }),
  
  components: {
    AppBarAccount: () => import("@/components/global/AppBarAccount"),
    AdInfo: () => import("@/components/ads/AdInfo"),
    TopButton: () => import("@/components/global/TopButton"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>
