<template>
  <div>
    <Bar />

    <!-- <v-row>
          <v-col justify="center">
            Teste
            <v-card class="card" justify="center">
              <v-img
                v-bind="attrs"
                v-on="on"
                src="@/assets/userImgTest.jpg"
                max-height="170"
                max-width="170"
              >
              </v-img> 
            </v-card>
          </v-col>
        </v-row>-->

    <v-container>
      <v-layout row wrap justify-space-around>
        <v-flex xs4 md3>
          <v-card class="cardPic">
            <v-img
              class="profilePic"
              mx-auto
              v-bind="attrs"
              v-on="on"
              src="@/assets/userImgTest.jpg"
            >
            </v-img>
          </v-card>
        </v-flex>

        <v-flex xs4 md3>
          <v-btn outline block class="success">2</v-btn>
        </v-flex>
      </v-layout>
    </v-container>

    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount"),
    Foot: () => import("@/components/global/Footer"),
  },
};
</script>

<style>
.profilepic {
  outline-color: black;
}

.cardPic {
  outline-color: lightsalmon;
}
</style>