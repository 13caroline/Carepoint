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
        text: "Queremos ajudá-lo a ajudar, por isso, comprometemo-nos a divulgar e a promover as suas competências numa das maiores plataformas digitais de assistência a idosos.",
        align: "start",
      },
      {
        text: "A nossa plataforma digital oferece-lhe um palco de divulgação nacional, onde pode transformar a sua carreiga e a sua marca.",
        align: "center",
      },
      {
        text: "Para que possa escolher o cuidador com que mais se identifica, reunimos uma vasta rede de prestadores e cuidadores que pode filtrar de acordo com os critérios que mais lhe aprouver.",
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

