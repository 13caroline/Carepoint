<template>
  <v-container>
    <v-row class="w-100" align="start">
      <v-col cols="auto">
        <div class="foto h-100 mt-5">
          <v-img
            src="@/assets/userImgTest.jpg"
            aspect-ratio="1"
            class="grey lighten-2 mx-2 rounded"
            cover
          >
            <template v-slot:placeholder>
              <v-row class="fill-height ma-0" align="center" justify="center">
                <v-progress-circular
                  indeterminate
                  color="grey lighten-5"
                ></v-progress-circular>
              </v-row>
            </template>
          </v-img>
        </div>
      </v-col>

      <v-col cols="12" sm>
        <v-card class="h-100 mt-2" flat>
          <v-list-item>
            <v-list-item-content>
              <div>
                <p class="infos font-weight-bold">Nome completo do prestador</p>
              </div>
              <div>
                <p class="infos font-weight-bold">Anos de experiência</p>
              </div>
              <div>
                <p class="desc">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
                  do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                  Ut enim ad minim veniam, quis nostrud exercitation ullamco
                  laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum
                  dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
                  minim veniam, quis nostrud exercitation ullamco laboris nisi
                  ut aliquip ex ea commodo consequat.
                </p>
                <v-divider></v-divider>
              </div>
            </v-list-item-content>
          </v-list-item>
        </v-card>
      </v-col>
    </v-row>

    <v-row class="w-100 ma-0">
      <v-col cols="12" md="2" sm="3">
        <span class="infos font-weight-bold">Classificação global</span>
        <div class="mt-4"><span class="classification">9.1</span> /10</div>
      </v-col>

      <v-col cols="12" md="10" sm="9">
        <span class="infos font-weight-bold">Serviços</span>
        <div class="mt-4">
          <v-chip-group active-class="primary--text" column>
            <v-chip
              v-for="c in category"
              :key="c"
              outlined
              color="#78C4D4"
              label
            >
              {{ c }}
            </v-chip>
          </v-chip-group>
        </div>
      </v-col>
    </v-row>

    <v-row class="w-100 ma-0">
        <v-col cols="12" md="4" sm="4">
            <p class="infos font-weight-bold">Contactos</p>
            <div class="infos">+351 9151212141</div>
            <div class="infos">exemplo@exemplo.com</div>
        </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "Ads",

  data() {
    return {
      category: ["Companhia", "Compras", "Medicação", "Higiene"],
    };
  },
};
</script>

<style scoped>
.infos {
  color: #797878;
}
.desc {
  color: #c4c4c4;
  text-align: justify;
  text-justify: inter-word;
}
.foto {
  width: 170px;
}
.classification {
  border-radius: 50%;
  width: 34px;
  height: 34px;
  padding: 10px;
  background: #fff;
  border: 1px solid #78c4d4;
  color: #000;
  text-align: center;
  font: 20px Arial, sans-serif;
}
</style>