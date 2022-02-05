<template>
  <div>
    <v-container>
      <v-row align="center">
        <v-col>
          <div class="text-center">
            <h3 class="font-weight-regular text-uppercase pb-10">
              Inscrever-se na Carepoint
            </h3>
            <v-row
              class="my-2"
              justify="center"
              v-for="p in options"
              :key="p.name"
            >
              <v-col cols="9" md="6" sm="7">
                <v-btn
                  block
                  outlined
                  color="#78C4D4"
                  depressed
                  class="rounded-lg button"
                  large
                  @click="register(p.route)"
                >
                  {{ p.name }}
                </v-btn>
              </v-col>
            </v-row>
          </div>
        </v-col>
      </v-row>

      <v-row align="center">
        <v-col cols="12" md="6">
          <v-img
            class="rounded-xl"
            center
            src="@/assets/usertype.jpg"
            max-height="220"
            contain
          >
          </v-img>
        </v-col>
        <v-col cols="12" md="6">
          <v-card class="mx-auto" flat>
            <v-carousel
              light
              :continuous="false"
              :cycle="true"
              :show-arrows="false"
              hide-delimiter-background
              delimiter-icon="mdi-minus"
              height="200"
            >
              <v-carousel-item v-for="(slide, i) in slides" :key="i">
                <v-sheet height="100%" tile>
                  <v-row class="fill-height" align="center" justify="center">
                    <v-col cols="auto">
                    <p class="slide mx-4">{{ slide }}</p>
                    </v-col>
                  </v-row>
                </v-sheet>
              </v-carousel-item>
            </v-carousel>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "UserType",
  data() {
    return {
      options: [
        {
          name: "Prestador Individual",
          route: "/register/provider/solo",
        },
        {
          name: "Prestador Coletivo",
          route: "/register/provider/collective",
        },
        { name: "Consumidor", route: "/register/consumer" },
      ],
      slides: [
        "Caso pretenda promover as suas competências como cuidador de idosos e alargar o seu leque de oportunidades, a Carepoint é a solução. Comprometemo-nos a criar e divulgar o seu perfil, onde destacaremos a sua experiência profissional, os seus sucessos e capacidades relevantes para o desempenho das funções. Para tal, basta preencher os respetivos formulários, optar por uma modalidade de subscrição dos serviços da Carepoint e aceitar os termos e condições gerais da Carepoint, que nós fazemos o que é necessário para impulsionar a sua carreira.",
        "Se representa uma empresa que presta serviços de assistência a idosos, tem de conhecera Carepoint, uma plataforma global que ajuda a alagar a visibilidade do seu negócio. A Carepoint dá-lhe acesso a uma enorme comunidade d eutilizadores que procuram respostas na área da assistência e cuidados à pessoa idosa e ainda a uma rede de cuidadores e trabalhadores especializados deste setor profissional. Após ter aceite os termos e condições gerais da Carepoint e realizado o respetivo pagamento do serviço, assumimos o compromisso de aumentar a presença onlina da sua empresa, bem como de maximizar a sua rede de contactos e de promover a sua marca.",
        "Se precisa de companhia, assistência ou cuidados para si ou um familiar e amigo, a Carepoint é a resposta que procura. Para usufruir de todas as funcionalidades da Carepoint, deve registar-se gratuitamente, preenchendo os respetivos formulários e aceitando os termos e condições gerais da empresa. A criação de uma conta pessoal na Carepoint permite-lhe agendar serviços, trocar mensagens com os cuidadores e publicar o seu próprio anúncio, por um preço irrisório de 1.99€.",
      ],
    };
  },
  methods: {
    register(route) {
      this.$router.push(route);
    },
  },
};
</script>

<style scoped>
.button:hover {
  background-color: #78c4d4;
  color: white !important;
}

h3 {
  color: #78c4d4;
}

.slide {
  color: #c4c4c4;
  text-align: justify;
  text-justify: inter-word;
  font-size: small;
}
</style>
