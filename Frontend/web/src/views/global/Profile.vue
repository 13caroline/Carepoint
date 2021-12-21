<template>
    <div>
        <Bar/>

    <Foot/>
    </div>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  components: {
    Bar: () => import('@/components/page/AppBarAccount.vue'),
    Foot: () => import("@/components/global/Footer")
  },
 
};
</script>