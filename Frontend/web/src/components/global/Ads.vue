<template>
  <v-item-group>
    <v-row>
      <v-col
        cols="auto"
        lg="4"
        md="4"
        class="mx-auto mx-sm-0"
        v-for="(a, index) in ads"
        :key="index"
      >
        <div class="user">
          <v-card
            class="card rounded-xl overflow-auto"
            outlined
            tile
            :style="styleObject"
            height="400"
            width="300"
            to="/ad/info"
          >
            <v-card-text>
              <span class="activity d-flex justify-end pb-2"
                >última vez ativo {{ difDate(a.lastActivity) }}</span
              >
              <v-row justify="center">
                <v-col cols="auto">
                  <v-avatar class="profile" color="grey" size="100">
                    <v-img :src="image"></v-img>
                  </v-avatar>
                </v-col>
              </v-row>

              <v-row justify="center" class="mx-auto">
                <span class="indication font-weight-bold">
                  {{ a.name }}
                </span>
              </v-row>

              <v-row justify="center" class="mx-auto">
                <span class="indication">
                  {{ a.location }}
                </span>
              </v-row>

              <v-divider class="mx-4 mt-5"></v-divider>

              <v-row justify="center" class="mx-auto">
                <span class="description">
                  {{ a.description }}
                </span>
              </v-row>
            </v-card-text>
          </v-card>
        </div>
      </v-col>
    </v-row>
  </v-item-group>
</template>

<script>
import axios from "axios"
import moment from "moment"
export default {
  name: "Ads",

  data() {
    return {
      image:'',
      styleObject: { border: "1px solid #78C4D4" },
      ads: [
        
      ],
    };
  },
  methods: {
    difDate(dateLA){
      return moment(dateLA).locale('pt').fromNow()
  },
  },

    created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/search/?page=1",
        {
          //id: this.id,
        },
        //{ headers: { Authorization: "Bearer " + store.getters.token } }
      );
      console.log(response.data.ServiceProviders)
      this.image='data:image/jpeg;base64,' + btoa(response.data.ServiceProviders.image);
      if (response) {
         this.ads = response.data.ServiceProviders.map(an => {
      an.image = an.image ? "data:image/jpeg;charset=utf-8;base64," + btoa(an.image) : require("@/assets/logo.png")
      return an;    
      })
        /*this.dados.image = this.dados.image
          ? "data:image/jpeg;charset=utf-8;base64," + this.dados.image
          : require("@/assets/image_placeholder.png");
      */}
    } catch (e) {
      this.$snackbar.showMessage({
        show: true,
        color: "error",
        text: "Ocorreu um erro. Por favor tente mais tarde!",
        timeout: 4000,
      });
    }
  }
};
</script>

<style scoped>
.user {
  width: 100%;
}

.round {
  border-radius: 100%;
}

.indication {
  text-align: center;
  color: #78c4d4;
}

.description {
  text-align: justify;
  text-justify: auto;
  color: grey;
  margin-top: 2em;
}

.activity {
  font-size: smaller;
}
</style>