<template>
  <div id="about" tag="section">
    <v-img src="@/assets/About.png" class="img" height="750px">
        <v-row no-gutters style="height: 100%" align="center" class="pa-10" >
          <v-col
            class="pa-md-16 pb-1"
            md="4"
            sm="6"
            v-for="(n, index) in content"
            :key="index"
            :align-self="n.align"
          >
            <v-card
              class="card mx-8"
              outlined
              tile
              :style="styleObject"
              width="225"
              height="225"
            >
              <v-card-text class="white--text">
                <p class="text-center">{{ n.text }} </p>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
    </v-img>
  </div>
</template>

<script>
export default {
  name: "HomeAbout",
  data: () => ({
    styleObject: { background: "transparent", border: "1px solid white" },
    content: [
      {
        text: "Lorem ipsum dolor sit amet, smod tempor incididunt ut labore et dolore magna aliqua.",
        align: "start",
      },
      {
        text: "Lorem ipsum dolor sit amet, smod tempor incididunt ut labore et dolore magna aliqua.",
        align: "center",
      },
      {
        text: "Lorem ipsum dolor sit amet, smod tempor incididunt ut labore et dolore magna aliqua.",
        align: "end",
      },
    ],
  }),
};
</script>

<style scoped>
.img {
  width: 100vw;
}

.card {
  height: 50;
  width: 50;
  padding-top:10%;

}

</style>

