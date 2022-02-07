<template>
  <v-container>
    <schedule></schedule>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      id: 0,
    };
  },
  components: {
    Schedule: () => import("@/components/ads/EditSchedules"),
  },
  
};
</script>

<style scoped>
.respos {
  text-align: end;
  font-weight: bold;
}

.infos {
  text-align: start;
}

.body-2 {
  font-size: 0.8rem !important;
}
.head {
  font-size: 2.75rem !important;
}
.font-weight-bold {
  font-size: 15px;
}
.font-weight-regular {
  font-size: 14px;
}
.font-weight-bold.col-sm-12.col-md-auto.col-auto {
  padding-bottom: 0;
}
.row.col.col-6 {
  margin-top: 0;
}
.foto {
  width: 170px;
}
.group {
  color: #282424;
  font-size: 20px;
}
.button:hover {
  background-color: #78c4d4;
  color: white !important;
}
</style>