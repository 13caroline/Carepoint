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
            <template>
              <v-btn
                raised
                rounded
                class="editImg"
                color="#78C4D4"
                outlined
                @click="onPick()"
              >
                Alterar fotografia
              </v-btn>
              <input
                type="file"
                class="editImg"
                style="display: none"
                ref="fileInput"
                accept="image/*"
              />
            </template>
            <!--<v-btn  color="#78C4D4" >Alterar fotografia</v-btn>-->
          </v-col>
        </v-flex>
        <v-flex xs4 md5>
          <v-col>
            <h3>Dados pessoais</h3>
            <v-card class="dadosCard" outlined>
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

              <v-icon class="editIcon" @click="openEditDialog()"
                >mdi-pencil</v-icon
              >
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
              <v-icon  class="editIcon" @click="openEditDialogAccess()"
                >mdi-pencil</v-icon
              >
            </v-card>
          </v-col>
        </v-flex>
      </v-layout>
      <v-layout row wrap justify-center align-center>
        <v-row>
          <v-flex xs4 md3> </v-flex>
        </v-row>
      </v-layout>

      <v-dialog v-model="dialog" persistent max-width="600px">
        <v-card>
          <v-card-title>
            <span class="text-h5">Dados Pessoais</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="12">
                  <span>Nome</span>
                  <v-text-field
                    disabled
                    placeholder="Maria Silva"
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <span>Telemóvel</span>
                  <v-text-field type="password" required></v-text-field>
                </v-col>
                <v-col cols="12" sm="6">
                  <v-select
                    :items="['Porto', 'Lisboa']"
                    label="Localidade"
                    required
                  ></v-select>
                </v-col>
                <v-col cols="12" sm="6">
                  <v-select
                    :items="['Masculino', 'Feminino', 'Outro']"
                    label="Sexo"
                  ></v-select>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" text @click="dialog = false">
              Close
            </v-btn>
            <v-btn color="blue darken-1" text @click="dialog = false">
              Save
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogAccess" persistent max-width="600px">
        <v-card>
          <v-card-title>
            <span class="text-h5">Dados de acesso</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="12">
                  <span>Email</span>
                  <v-text-field                
                    placeholder="maria_silva_41@gmail.com"
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <span>Password</span>
                  <v-text-field type="password" placeholder="******"></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" text @click="dialog = false">
              Close
            </v-btn>
            <v-btn color="blue darken-1" text @click="dialog = false">
              Save
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-container>

    <Foot />
  </div>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      dialogAccess: false,
      maxNumberOfChoices: 1,
    };
  },
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
  },
  computed: {
  },
  methods: {
    openEditDialog() {
      this.dialog = true;
    },
    openEditDialogAccess() {
      this.dialogAccess = true;
    },
    onPick() {
      this.$refs.fileInput.click();
    },
    
  },
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

.editImg {
  margin-top: 10%;
  margin-left: 11%;
  border: solid #78c4d4;
}
</style>

