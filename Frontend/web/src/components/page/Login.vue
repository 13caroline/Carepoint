<template>
  <div id="about" tag="section">
    <v-img src="@/assets/login.jpg" class="img" height="750px">
    <v-container>
      <v-row align="center" justify="center">
        <v-col cols="3">
          <span>E-mail</span>
          <v-text-field
            v-model="email"
            outlined
            dense
            class="rounded-xl txtfield"
            background-color="white"
            color="#78C4D4"
          ></v-text-field>
          <span>Password</span>
          <v-text-field
            v-model="password"
            outlined
            dense
            class="rounded-xl txtfield"
            background-color="white"
            color="#78C4D4"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row  align="center" justify="center">
        <v-btn text color="#78C4D4"> Increva-se </v-btn>
        <v-btn dark depressed class="rounded-xl" color="#78C4D4"> Iniciar Sessão </v-btn>
      </v-row>
      </v-container>
    </v-img>
  </div>
</template>

<script>
export default {
  name: "HomeLogin",

  data: () => ({
    email: "",
    password: "",
    styleObject: { background: "transparent", border: "1px solid white" },
    content: [
      {
        text: "Lorem ipsum dolor sit amet, smod tempor incididunt ut labore et dolore magna aliqua.",
        align: "start",
      },
      {
        text: "Lorem ipsum dolor sit amet, smod tempor incididunt ut labore et dolore magna aliqua.",
        align: "center",
      },
      {
        text: "Lorem ipsum dolor sit amet, smod tempor incididunt ut labore et dolore magna aliqua.",
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
  padding-top: 10%;
}

span {
  font-size: small;
  color: #78c4d4;
}

.txtfield {
  outline-color: #78c4d4;
}
</style>

