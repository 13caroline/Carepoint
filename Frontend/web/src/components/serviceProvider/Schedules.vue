<template>
  <v-container>
    <v-row justify="end">
      <v-col cols="auto">
        <NewSlot @clicked="updated"></NewSlot>
      </v-col>
    </v-row>
    <schedule :dados="id"></schedule>
  </v-container>
</template>

<script>
//import moment from "moment"
import axios from "axios";
import store from "@/store/index.js";
export default {
  data() {
    return {
      id: 0,
    };
  },
  components: {
    NewSlot: () => import("@/components/dialogs/NewSlot"),
    Schedule: () => import("@/components/ads/Schedule"),
  },
  methods: {
    updated: async function(){
      try {
      let response = await axios.post("http://localhost:9040/users/id", {
        token: store.getters.token,
      });
      this.id = response.data;
    } catch (e) {
      console.log(e);
    }

    }
  },
  created: async function () {
    this.updated();
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