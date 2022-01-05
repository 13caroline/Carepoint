<template>
  <div id="login" tag="section">
    <v-img src="@/assets/login.jpg" class="img">
      <v-container>
        <v-row align="center" justify="center" class="login_wrapper">
          <v-card color="transparent" flat class="loginform my-12">
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
              <v-btn
                depressed
                dark
                color="#78c4d4"
                type="submit"
                class="rounded-lg"
                @click="login()"
              >
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
import axios from "axios";
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

    async login() {
      if (this.$refs.form.validate()) {
        try {
          var res = await axios.post("http://localhost:9041/users/login", {
            email: this.email,
            password: this.password,
          });
          if (res.data.token != undefined) {
            this.$store.commit("guardaTokenUtilizador", res.data.token);
            this.$store.commit("guardaTipoUtilizador", res.data.type);
            if (res.data.type == "2") {
              this.$router.push("/consumer/page");
            }
          }
        } catch (error) {
          this.text = "Ocorreu um erro. Por favor tente mais tarde!";
          this.color = "warning";
          this.$snackbar.showMessage({
            show: true,
            color: this.color,
            text: this.text,
            timeout: 4000,
          });
        }
      }
    },
  },
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

