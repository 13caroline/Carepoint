<template>
  <div>
    <v-app-bar flat color="#FFFFFF" height="180">
      <v-container>
        <v-layout row>
          <v-col class="d-flex justify-space-around">
            <v-img
              align-center
              center
              src="@/assets/logo.png"
              max-height="220"
              max-width="220"
            >
            </v-img>
          </v-col>
          <v-col>
               <v-btn
                outlined 
                color="#78C4D4"
                depressed
                class="rounded-xl"
            >
             Iniciar Sessão
            </v-btn>
          </v-col>
        </v-layout>
        
           
       
      </v-container>
    </v-app-bar>
  </div>
</template>

<script>

export default {
  name: "appbar",
  data() {
    return {};
  },
};
</script>