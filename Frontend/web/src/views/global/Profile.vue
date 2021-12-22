<template>
  <div>
    <Bar />
    <!--  <v-container>
          <v-layout row wrap justify-center>
            <v-flex xs4 md3>
              <v-card class="cardPic">
              <v-img
              contain
              max-height="300"
              class="profilePic"
                v-bind="attrs"
                v-on="on"
                src="@/assets/userImgTest.jpg"
              >
              </v-img> 
              </v-card>
            </v-flex>

            <v-flex xs4 md3>
            </v-flex>
          </v-layout>
        </v-container>
        -->
    <v-container>
      <v-layout row wrap justify-center align-center>
        
          <v-flex xs4 md3>
          <v-col cols="12" md="auto">
            <div class="foto mx-auto">
              <v-img
                src="@/assets/userImgTest.jpg"
                class="grey lighten-2 mx-2 rounded"
                cover
              >
                <template v-slot:placeholder>
                  <v-row
                    class="fill-height ma-0"
                    align="center"
                    justify="center"
                  >
                    <v-progress-circular
                      indeterminate
                      color="grey lighten-5"
                    ></v-progress-circular>
                  </v-row>
                </template>
              </v-img>
            </div>
          </v-col>
          </v-flex>
          <v-flex xs4 md5>
          <v-col>
            <v-card  class="dadosCard" outlined >
              <v-list-item class="my-auto">
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col justify-end>
                        <p class="infos">Nome</p>
                      </v-col>
                      <v-col>
                        <p class="respos">Maria Silva</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col justify-end>
                        <p class="infos">Email</p>
                      </v-col>
                      <v-col >
                        <p class="respos">maria_silva_41@gmail.com</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col >
                        <p class="infos">Localização</p>
                      </v-col>
                      <v-col>
                        <p class="respos">Porto</p>
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
          </v-flex>
      </v-layout>
      <v-layout row wrap justify-center align-center>
       <v-row>
         <v-flex xs4 md3>
          <v-btn outline>Editar Imagem</v-btn>
          </v-flex>
        </v-row>
        </v-layout>
    </v-container>

    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {
    };
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

span {
  font-weight: bold;
}

.dadosCard{
  margin-bottom: 5em;
}

.respos{
  font-weight: bold;
}
</style>

