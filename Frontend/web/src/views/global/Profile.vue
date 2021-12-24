<template>
  <div>
    <Bar />
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
            <v-btn raised rounded class="editImg" color="#78C4D4" outlined @click="onPick()"> Alterar fotografia </v-btn>
            <input type="file" class="editImg" style="display: none" ref="fileInput" accept="image/*">
            <!--<v-btn  color="#78C4D4" >Alterar fotografia</v-btn>-->
          </v-col>
        </v-flex>
        <v-flex xs4 md5>
          <v-col>
            <h3>Dados pessoais</h3>
            <v-card  class="dadosCard" outlined>
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
                        <p class="infos">Telemóvel</p>
                      </v-col>
                      <v-col>
                        <p class="respos">918273339</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Sexo</p>
                      </v-col>
                      <v-col>
                        <p class="respos">Feminino</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Localidade</p>
                      </v-col>
                      <v-col>
                        <p class="respos">Porto</p>
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
                <v-icon class="editIcon" @click="doesSomething()">mdi-pencil</v-icon>
            </v-card>
            <h3>Dados de acesso</h3>
            <v-card class="dadosCard" outlined>
              <v-list-item class="my-auto">
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col justify-end>
                        <p class="infos">Email</p>
                      </v-col>
                      <v-col>
                        <p class="respos">maria_silva_41@gmail.com</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col justify-end>
                        <p class="infos">Password</p>
                      </v-col>
                      <v-col>
                        <p class="respos">pass</p>
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
          <v-flex xs4 md3> </v-flex>
        </v-row>
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
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
  },
  methods: {
    doesSomething(){
      console.log("Does something")
    },
    onPick(){
      this.$refs.fileInput.click()
    }
  }
};
</script>

<style>
.profilepic {
  outline-color: black;
}

span {
  font-weight: bold;
}

.dadosCard {
  margin-bottom: 5em;
}

.respos {
  font-weight: bold;
}

.editImg{
  margin-top: 10%;
  margin-left:11%;
  border:  solid #78C4D4;

}
</style>

