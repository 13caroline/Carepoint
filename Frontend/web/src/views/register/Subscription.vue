<template>
  <div>
    <app-bar-account />
    <TypeSub/>
    <Foot />
  </div>
</template>

<script>
export default {
  data: () => ({
    
  }),
  
  components: {
    AppBarAccount: () => import("@/components/global/AppBarAccount"),
    TypeSub: () => import("@/components/global/TypeSub"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>
