<template>
    <div>
        <Bar/>
        
        <Foot/>
    </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
  },

  methods: {
  },
};
</script>