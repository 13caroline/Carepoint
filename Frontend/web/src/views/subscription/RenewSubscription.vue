<template>
  <div>
    <app-bar-account />
    <UpdateSubscription/>
    <Foot />
  </div>
</template>

<script>
export default {
  data: () => ({
    
  }),
  
  components: {
    AppBarAccount: () => import("@/components/global/AppBarAccount"),
    UpdateSubscription: () => import("@/components/serviceProvider/UpdateSubscription"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>
