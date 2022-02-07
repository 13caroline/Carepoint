<template>
  <div>
    <v-dialog v-model="dialog" width="100%" max-width="700" persistent>
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          dense
          color="#78c4d4"
          depressed
          class="rounded-lg white--text mb-2"
          v-bind="attrs"
          v-on="on"
        >
          Alterar palavra-passe
        </v-btn>
      </template>
      <v-card class="rounded-lg">
        <v-card-title class="font-weight-bold pt-6">
          Alterar palavra-passe
        </v-card-title>
        <v-card-subtitle class="text-subtitle-1"> </v-card-subtitle>
        <v-card-text>
          <v-form ref="form" v-model="valid">
            <v-divider></v-divider>
            <v-row class="mt-3">
              <v-col>
                <span>Palavra-passe atual</span>
                <v-text-field
                  outlined
                  color="#78c4d4"
                  :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                  @click:append="show1 = !show1"
                  :type="show1 ? 'text' : 'password'"
                  required
                  dense
                  v-model="form.oldPassword"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6" md="6" lg="6" xl="6">
                <span>Nova palavra-passe</span>
                <v-text-field
                  outlined
                  required
                  color="#78c4d4"
                  :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                  @click:append="show2 = !show2"
                  :type="show2 ? 'text' : 'password'"
                  :rules="passwordRules"
                  dense
                  v-model="form.newPassword"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="6" lg="6" xl="6">
                <span>Repita a palavra-passe</span>
                <v-text-field
                  outlined
                  required
                  color="#78c4d4"
                  :append-icon="show3 ? 'mdi-eye' : 'mdi-eye-off'"
                  @click:append="show3 = !show3"
                  :type="show3 ? 'text' : 'password'"
                  :rules="[
                    form.newPassword === form.newPasswordRepeat ||
                      'As palavra-passes devem corresponder.',
                  ]"
                  dense
                  v-model="form.newPasswordRepeat"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>

        <v-card-actions class="mt-0">
          <v-row class="mb-0">
            <v-col cols="12" md="6">
              <v-btn
                depressed
                large
                outlined
                dark
                block
                color="#78c4d4"
                @click="dialog = false"
              >
                Cancelar
              </v-btn>
            </v-col>
            <v-col cols="12" md="6">
              <v-btn
                depressed
                large
                dark
                block
                color="#78c4d4"
                @click="change()"
              >
                Alterar
              </v-btn>
            </v-col>
          </v-row>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";

export default {
  props: ["id"],
  data: () => ({
    show1: false,
    show2: false, 
    show3: false,
    passwordRules: [
      (v) => !!v || "Palavra-passe inválida",
      (v) => /(?=.*[A-Z])/.test(v) || "Deve ter uma letra maiúscula",
      (v) => /(?=.*\d)/.test(v) || "Deve ter um número",
      (v) =>
        (v && v.length >= 5) ||
        "A palavra-passe deve ter pelo menos 5 caracteres",
    ],
    dialog: false,
    oldPassword: "",
    newPassword: "",
    newPasswordRepeat: "",
    length: 10,
    valid: false,
    form: {
      rating: 5,
      description: "",
    },
  }),
  methods: {
    change: async function () {
      if (this.$refs.form.validate()) {
        try {
          await axios.put("http://localhost:9040/users/updatePassword", {
            token: store.getters.token,
            idUser: this.id,
            oldPassword: this.form.oldPassword,
            newPassword_1: this.form.newPassword,
            newPassword_2: this.form.newPasswordRepeat,
          });
          this.$emit("clicked", "update");
          (this.dialog = false),
            this.$snackbar.showMessage({
              show: true,
              text: "Palavra-passe alteradaw com sucesso.",
              color: "success",
              snackbar: true,
              timeout: 4000,
            });
        } catch (e) {
          this.$snackbar.showMessage({
            show: true,
            color: "warning",
            text: "Ocorreu um erro, por favor tente mais tarde!",
            timeout: 4000,
          });
        }
      } else {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Por favor preencha todos os campos.",
          timeout: 4000,
        });
      }
    },
  },
};
</script>

<style scoped>
.group {
  color: #282424;
  font-size: 20px;
}
</style>