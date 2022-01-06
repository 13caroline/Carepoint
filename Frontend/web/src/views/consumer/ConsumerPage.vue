<template>
  <div id="page">
    <app-bar />
    
    <view-ads />
    <top-button/>
    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  components: {
    AppBar: () => import("@/components/global/AppBarAccount"),
    ViewAds: () => import('@/components/ads/ViewAds.vue'),
    TopButton: () => import("@/components/global/TopButton"),
    Foot: () => import("@/components/global/Footer")
  },
};
</script>