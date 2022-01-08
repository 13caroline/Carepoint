<template>
  <v-container>
      <v-card flat>
        <v-row>
          <v-col cols="auto" class="ml-auto">
            <v-btn
              class="body-2 rounded-xl button"
              small
              color="#78C4D4"
              outlined
              dark
              to="/consumer/edit/profile"
            >
              Renovar subscrição
              <v-icon small class="ml-2">fas fa-sync</v-icon>
            </v-btn>
            <v-btn
              class="body-2 rounded-xl button ml-2"
              small
              color="#78C4D4"
              outlined
              dark
              to="/consumer/edit/profile"
            >
              Cancelar subscrição
              <v-icon small class="ml-2">fas fa-times</v-icon>
            </v-btn>

           
          </v-col>
        </v-row>

        <h3 class="group font-weight-light text-uppercase">
          Subscrição
        </h3>
        <v-divider></v-divider>
        <v-row class="w-100" align="start">
          <v-col cols="12" sm>
            <v-card class="h-100 mt-5" outlined>
              <v-list-item>
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Subscrição</p>
                      </v-col>
                      <v-col>
                        <p v-if= "user.subDuration[6] == 1" class="respos">1 mês</p>
                        <p v-else>{{user.subDuration[6]}} meses </p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Valor</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{user.subValue}}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos mb-0">Data término</p>
                      </v-col>
                      <v-col>
                        <p class="respos mb-0">{{convertDate(this.user.endSub) }}</p>
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
          
        </v-row>

        <h3 class="mt-6 group font-weight-light text-uppercase">
          Visibilidade
        </h3>
        <v-divider></v-divider>

        <v-row class="w-100" align="start">
          <v-col>
            <v-card class="h-100 mt-5" outlined>
              <v-list-item>
                <v-list-item-content>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Visibilidade</p>
                      </v-col>
                      <v-col>
                        <p class="respos">{{user.email}}</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Duração</p>
                      </v-col>
                      <v-col>
                        <p class="respos">*****</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos">Valor</p>
                      </v-col>
                      <v-col>
                        <p class="respos">*****</p>
                      </v-col>
                    </v-row>
                  </div>
                  <div>
                    <v-row>
                      <v-col>
                        <p class="infos mb-0">Data término</p>
                      </v-col>
                      <v-col>
                        <p class="respos mb-0">*****</p>
                      </v-col>
                    </v-row>
                  </div>
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
        </v-row>
      </v-card>
    </v-container>
</template>

<script>
import moment from "moment"
  export default{
    props: ["user"],
    data(){
      return{
          
      }
    },
    methods: {
        convertDate(d){
           return moment(d , moment.ISO_8601).format("DD-MM-YYYY")
        }
    },
    components:{

    }
  }

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