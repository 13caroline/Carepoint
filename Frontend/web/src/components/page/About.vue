<template>
  <div id="about" tag="section">
    <v-img src="@/assets/About.png" class="img" height="750px">
      <v-container class="mt-10">
        <v-row no-gutters style="height: 600px">
          <v-col
            cols="12"
            md="4"
            sm="6"
            v-for="(n, index) in content"
            :key="index"
            :align-self="n.align"
          >
            <v-card
              class="card"
              outlined
              tile
              :style="styleObject"
              width="250"
              height="250"
            >
              <v-card-text class="white--text text-center">
                {{ n.text }}
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
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
}
</style>

