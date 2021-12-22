<template>
  <div id="login" tag="section">
    <v-img src="@/assets/login.jpg" class="img">
      <v-container>
        <v-row align="center" justify="center" class="login_wrapper">
          <v-card color = "transparent" flat class="loginform my-12">
            <v-card-text class="justify-center">
              <v-form ref="form" lazy-validation class="form">
                <span>Email</span>
                <v-text-field
                  v-model="email"
                  outlined
                  dense
                  class="rounded-lg"
                  color="#78C4D4"
                  background-color="white"
                  required
                ></v-text-field>

                <span>Palavra-passe</span>
                <v-text-field
                  dense
                  outlined
                  color="#78c4d4"
                  class="rounded-lg"
                  name="password"
                  type="password"
                  v-model="password"
                  background-color="white"
                  required
                />
              </v-form>
            </v-card-text>
            <v-card-actions class="card-actions">
              <v-spacer></v-spacer>
              <v-btn depressed text color="#78c4d4" @click="register()">
                Inscrever-se
              </v-btn>
              <v-btn depressed dark color="#78c4d4" type="submit" rounded @click="login()">
                Iniciar Sessão
              </v-btn>
            </v-card-actions>
          </v-card>
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
  }),
  methods: {
    register() {
      this.$router.push("/register/type");
    },
    
    login() {
      this.$router.push("/consumer/profile");
    }
  }
};
</script>

<style scoped>
.img {
  width: 100vw;
  height: 80vh;
}

span {
  font-size: small;
  color: #78c4d4;
}

.card-actions {
  margin-top: 1px;
  width: 100%;
  margin-left: auto;
  margin-right: auto;
}
.form {
  margin-top: 1rem;
}

.login_wrapper {
  min-height: 60vh;
}

.loginform {
  width: 100%;
  max-width: 475px;
}
</style>

