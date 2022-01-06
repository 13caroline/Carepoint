<template>
  <div>
    <app-bar-account />
    <TypeSub :id="$route.params.id"/>
    <Foot />
  </div>
</template>

<script>
export default {
  data: () => ({
    
  }),
  
  components: {
    AppBarAccount: () => import("@/components/global/AppBarAccount"),
    TypeSub: () => import("@/components/subscription/TypeSub"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>
