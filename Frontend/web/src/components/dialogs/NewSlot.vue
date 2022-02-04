<template>
  <v-dialog v-model="dialog" width="100%" max-width="500" persistent>
    <template v-slot:activator="{ diag, attrs }">
      <v-tooltip top>
        <template v-slot:activator="{ on }">
          <v-btn
            color="#78C4D4"
            class="mb-2 ml-2"
            v-bind="attrs"
            v-on="{ ...on, ...diag }"
            small
            fab
            dark
            @click="dialog = true"
          >
            <v-icon small> fas fa-plus</v-icon>
          </v-btn>
        </template>
        <span class="caption">Registar horário</span>
      </v-tooltip>
    </template>
    <v-card>
      <v-form ref="form" v-model="valid">
        <v-card-title class="font-weight-regular text-uppercase">
          Registar um novo horário
        </v-card-title>
        <v-card-subtitle
          >Por favor preencha o seguinte formulário</v-card-subtitle
        >
        <v-divider></v-divider>

        <v-card-text class="mt-4">
          <v-row align="center">
            <v-col cols="12" md="10" class="py-0 mx-auto">
              <span>Dia da semana *</span>
              <v-autocomplete
                outlined
                flat
                dense
                v-model="form.date"
                :items="dates"
                item-value="date"
                item-text="id"
                :rules="textRules"
                color="#78C4D4"
                name="date"
                required
              />
            </v-col>

            <v-col cols="12" md="10" class="py-0 mx-auto">
              <span>Hora início *</span>
              <v-menu
                ref="horaInicio"
                v-model="horaInicio"
                :close-on-content-click="false"
                :nudge-right="40"
                :return-value.sync="horaInicio"
                transition="scale-transition"
                offset-y
                max-width="290px"
                min-width="290px"
              >
                <template v-slot:activator="{ on }">
                  <v-text-field
                    append-icon="fas fa-clock"
                    color="#78C4D4"
                    v-on="on"
                    outlined
                    :rules="textRules"
                    dense
                    v-model="hora"
                  ></v-text-field>
                </template>
                <v-time-picker
                  format="24hr"
                  v-model="hora"
                  full-width
                  min="10:00"
                  max="19:45"
                  :allowed-minutes="allowedStep"
                  color="#78C4D4"
                ></v-time-picker>
              </v-menu>
            </v-col>

            <v-col cols="12" md="10" class="py-0 mx-auto">
              <span>Hora término *</span>
              <v-menu
                ref="horaTermino"
                v-model="horaTermino"
                :close-on-content-click="false"
                :nudge-right="40"
                :return-value.sync="horaTermino"
                transition="scale-transition"
                offset-y
                max-width="290px"
                min-width="290px"
              >
                <template v-slot:activator="{ on }">
                  <v-text-field
                    append-icon="fas fa-clock"
                    color="#78C4D4"
                    v-on="on"
                    outlined
                    dense
                    :rules="textRules"
                    v-model="hora2"
                  ></v-text-field>
                </template>
                <v-time-picker
                  format="24hr"
                  v-model="hora2"
                  full-width
                  :min="hora + 30"
                  max="19:45"
                  :allowed-minutes="allowedStep"
                  color="#78C4D4"
                ></v-time-picker>
              </v-menu>
            </v-col>
          </v-row>
          <v-row align="end" justify="end">
            <v-col cols="auto">
              <Cancelar :dialogs="cancelar" @clicked="close()"></Cancelar>
            </v-col>
            <v-col cols="auto">
              <v-btn
                depressed
                class="white--text"
                color="#78c4d4"
                @click="register()"
                :disabled="!valid"
              >
                Registar
              </v-btn>
            </v-col>
          </v-row>
        </v-card-text>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";
import Cancelar from "@/components/dialogs/Cancel.vue";
export default {
  data: () => ({
    dialog: false,
    horaInicio: null,
    horaTermino: null,
    hora: "08:00",
    hora2: "09:00",
    textRules: [(v) => !!v || "Campo obrigatório"],
    medicos: [],
    dates: [
      { id: "Segunda-feira", date: "2022-01-03" },
      { id: "Terça-feira", date: "2022-01-04" },
      { id: "Quarta-feira", date: "2022-01-05" },
      { id: "Quinta-feira", date: "2022-01-06" },
      { id: "Sexta-feira", date: "2022-01-07" },
      { id: "Sábado", date: "2022-01-08" },
      { id: "Domingo", date: "2022-01-09" },
    ],
    cat: [],
    dialogs: {},
    form: {
      date: null,
    },
    cancelar: {
      title: "registo de horário",
      text: "o registo de horário",
    },
    valid: false,
  }),
  components: {
    Cancelar,
  },
  methods: {
    allowedStep: (m) => m % 30 === 0,

    close() {
      this.dialog = false;
    },

    register: async function () {
      if (this.$refs.form.validate()) {
        let data1 = this.form.date + " " + this.hora;
        let data2 = this.form.date + " " + this.hora2;
        try {
          
          await axios.put("http://localhost:9040/serviceProvider/regHorario", {
            token: store.getters.token,
            dateBegin: data1,
            dateEnd: data2,
          });
          this.$emit("clicked", "update");
          (this.dialog = false),
            this.$snackbar.showMessage({
              show: true,
              text: "Horário registado com sucesso.",
              color: "success",
              snackbar: true,
              timeout: 4000,
            });
        } catch (error) {
          let message = "";
          error.response.data.error == "Slot do Hórario já se encontra ocupado."
            ? (message = "Este slot já se encontra registado.")
            : (message = "Ocorreu um erro, por favor tente mais tarde!");
          this.$snackbar.showMessage({
            show: true,
            color: "warning",
            text: message,
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

  created: async function () {
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