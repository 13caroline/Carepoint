<template>
  <v-container id="careproviders" tag="section">
    <v-card flat>
      <v-container>
        <v-row justify="center" align="center">
          <v-col cols="12" md="6" sm="2">
            <v-card-title class="headline card" >
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
                  :items="items"
                  :rules="[(v) => !!v || 'Campo obrigatório.']"
                  required
                  outlined
                  dense
                  class="rounded-lg"
                  color="#78C4D4"
                ></v-select>

                <span>Localização</span>
                <v-text-field
                  v-model="location"
                  outlined
                  dense
                  class="rounded-lg"
                  color="#78C4D4"
                ></v-text-field>
              </v-form>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn dark depressed class="rounded-lg" color="#78C4D4">
                Procurar
              </v-btn>
            </v-card-actions>
          </v-col>

          <v-col cols="12" md="4" sm="4"> 
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
export default {
  name: "HomePC",
  data() {
    return {
      items: ["Companhia", "Compras", "Higiene", "Medicação", "Refeições"],
      category: "",
      location: "",
    };
  },
};
</script>

<style scoped>

span {
  font-size: small;
  color: #78C4D4;
}

.card{
  word-break: keep-all; 
}
</style>