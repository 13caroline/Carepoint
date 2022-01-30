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
                <p v-bind:class="n.paddding">{{ n.text }} </p>
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
        text: "Queremos ajudá-lo a ajudar, por isso, comprometemo-nos a divulgar e a promover as suas competências numa das maiores plataformas digitais de assistência a idosos.",
        align: "start",
        paddding: "text-center mt-6 mt-sm-6 mt-md-6 mt-lg-6 mt-xl-5",
      },
      {
        text: "A nossa plataforma digital oferece-lhe um palco de divulgação nacional, onde pode transformar a sua carreiga e a sua marca.",
        align: "center",
        paddding: "text-center mt-9 mt-sm-9 mt-md-9 mt-lg-9 mt-xl-5",
      },
      {
        text: "Para que possa escolher o cuidador com que mais se identifica, reunimos uma vasta rede de prestadores e cuidadores que pode filtrar de acordo com os critérios que mais lhe aprouver.",
        align: "end",
        paddding: "text-center mt-5 mt-sm-4 mt-md-5 mt-lg-5 mt-xl-5",
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

