<template>
  <v-container id="careproviders" tag="section">
    <v-card flat>
      <v-container>
        <v-row justify="center" align="center">
          <v-col cols="12" md="6">
            <v-card-title class="headline card">
              Encontre a ajuda doméstica perfeita para si e sua família!
            </v-card-title>

            <v-card-subtitle class="card">
              Crie um perfil gratuitamente e encontre o cuidador ideal!
            </v-card-subtitle>

            <v-card-text>
              <v-form>
                <span>Categoria</span>
                <v-select
                  v-model="category"
                  :items="cat"
                  :rules="[(v) => !!v || 'Campo obrigatório.']"
                  required
                  outlined
                  item-value="idCategory"
                  item-text="name"
                  dense
                  class="rounded-lg"
                  color="#78C4D4"
                ></v-select>

                <span>Localização</span>
                <v-autocomplete
                  v-model="location"
                  outlined
                  item-value="idLocation"
                  item-text="name"
                  dense
                  :items="loc"
                  class="rounded-lg"
                  color="#78C4D4"
                ></v-autocomplete>
              </v-form>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn dark depressed class="rounded-lg" color="#78C4D4" @click="search()">
                Procurar
              </v-btn>
            </v-card-actions>
          </v-col>

          <v-col cols="12" md="4">
            <v-img
              class="rounded-xl"
              center
              src="@/assets/CareProviders.jpg"
              height="250"
              width="500"
            >
            </v-img>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-container>
</template>

<script>
import axios from "axios";
export default {
  name: "HomePC",
  data() {
    return {
      cat: [],
      loc: [],
      category: "",
      location: "",
      info: {}
    };
  },
  methods:{
    search(){
      this.$router.push("/search/" + this.category + "/" + this.location)
    }
  },
  created: async function () {
    try {
      let response2 = await axios.get("http://localhost:9040/location");
      if (response2) {
        this.loc = response2.data;
      }
    } catch (e) {
      console.log(e);
    }

    try {
      let response3 = await axios.get("http://localhost:9040/category");
      if (response3) {
        this.cat = response3.data;
      }
    } catch (e) {
      console.log(e);
    }
  },
};
</script>

<style scoped>
span {
  font-size: small;
  color: #78c4d4;
}

.card {
  word-break: keep-all;
}
</style>