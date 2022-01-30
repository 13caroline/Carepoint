<template>
  <div>
    <div>
      <v-sheet height="600">
        <v-calendar
          v-if="events"
          ref="calendar"
          :start="today"
          :events="events"
          color="#78C4D4"
          type="week"
          :weekdays="weekday"
          locale="PT"
          event-color="#78C4D4"
          @click:event="showEvent"
        >
          <template v-slot:day-label-header="{}">-</template>
        </v-calendar>
        <small v-else> <em> não existem horários registados </em></small>
        <v-menu
          v-if="selectedEvent.occupied == 0"
          v-model="selectedOpen"
          :close-on-content-click="false"
          :activator="selectedElement"
          offset-x
          max-width="500px"
        >
          <v-card flat>
            <v-form ref="form" v-model="valid">
              <v-card-title class="font-weight-regular text-uppercase">
                Requisitar um horário
              </v-card-title>
              <v-card-subtitle
                >Por favor preencha o seguinte formulário</v-card-subtitle
              >
              <v-divider></v-divider>

              <v-card-text class="mt-4">
                <v-row align="center">
                  <v-col cols="12" md="10" class="py-0 mx-auto">
                    <span>Categorias *</span>
                    <v-autocomplete
                      outlined
                      flat
                      dense
                      :items="cat"
                      item-value="idCategory"
                      item-text="name"
                      :rules="[(v) => !!v || 'Campo obrigatório.']"
                      color="#78C4D4"
                      required
                      chips
                      v-model="categories"
                      small-chips
                      multiple
                    />
                  </v-col>

                  <v-col cols="12" md="10" class="py-0 mx-auto">
                    <span>Dia da semana *</span>
                    <v-text-field
                      outlined
                      flat
                      dense
                      color="#78C4D4"
                      v-model="day"
                      disabled
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
                          :rules="[(v) => !!v || 'Campo obrigatório.']"
                          dense
                          v-model="hora"
                        ></v-text-field>
                      </template>
                      <v-time-picker
                        format="24hr"
                        v-model="hora"
                        full-width
                        :min="date_begin"
                        :max="date_end"
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
                          :rules="[(v) => !!v || 'Campo obrigatório.']"
                          v-model="hora2"
                        ></v-text-field>
                      </template>
                      <v-time-picker
                        format="24hr"
                        v-model="hora2"
                        full-width
                        :min="date_begin"
                        :max="date_end"
                        :allowed-minutes="allowedStep"
                        color="#78C4D4"
                      ></v-time-picker>
                    </v-menu>
                  </v-col>
                </v-row>
                <v-row align="end" justify="end">
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
        </v-menu>
      </v-sheet>
    </div>
  </div>
</template>

<script>
import moment from "moment";
import axios from "axios";
import store from "@/store/index.js";
export default {
  props: ["dados"],
  data: () => ({
    today: "2022-01-03",
    valid: false,
    events: [],
    styleObject: { border: "1px solid #78C4D4" },
    start: null,
    end: null,
    occupied: null,
    name: null,
    horaInicio: null,
    horaTermino: null,
    hora: "",
    hora2: "",
    weekday: [1, 2, 3, 4, 5, 6, 0],
    type: "",
    categories: [],
    cat: [],
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
    day: "",
    date_begin: "", 
    date_end: ""
  }),
  mounted() {
    this.$refs.calendar.scrollToTime("08:00");
  },
  methods: {
    allowedStep: (m) => m % 30 === 0,
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.day = moment(event.start).format("YYYY-MM-DD");
        this.date_begin = moment(event.start).format("HH:mm");
        this.date_end = moment(event.end).format("HH:mm")
        this.selectedEvent = event;
        this.selectedElement = nativeEvent.target;
        requestAnimationFrame(() =>
          requestAnimationFrame(() => (this.selectedOpen = true))
        );
      };
      if (this.selectedOpen) {
        this.selectedOpen = false;
        requestAnimationFrame(() => requestAnimationFrame(() => open()));
      } else {
        open();
      }
      nativeEvent.stopPropagation();
    },
    register: async function () {
      if (this.$refs.form.validate()) {
        let data1 = this.day + " " + this.hora;
        let data2 = this.day + " " + this.hora2;
        try {
          console.log(data1);
          console.log(data2);
          await axios.put("http://localhost:9040/serviceProvider/newSlot", {
            token: store.getters.token,
            dateBegin: data1,
            dateEnd: data2,
            spId: this.dados,
            categories: this.categories,
          });
          this.$emit("clicked", "update");

          this.$snackbar.showMessage({
            show: true,
            text: "Horário requisitado com sucesso.",
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
  created: async function () {
    try {
      let response3 = await axios.get("http://localhost:9040/category");
      if (response3) {
        this.cat = response3.data;
      }

      let response = await axios.get(
        "http://localhost:9040/serviceProvider/horarios/?id=" + this.dados
      );
      let workSchedule = null;
      let occupiedSchedule = null;
      if (response.data.categories[0].workSchedule !== null) {
        workSchedule = response.data.categories[0].workSchedule;

        for (var i = 1; i < workSchedule.length; i++) {
          this.events.push({
            start: workSchedule[i].date_begin,
            end: workSchedule[i].date_end,
            occupied: 0,
          });
        }

        if (response.data.categories[0].occupiedSchedule !== null) {
          occupiedSchedule = response.data.categories[0].occupiedSchedule;
          for (var k = 1; k < occupiedSchedule.length; k++) {
            this.events.push({
              start: occupiedSchedule[k].date_begin,
              end: occupiedSchedule[k].date_end,
              occupied: 1,
            });
          }
        }
      }
    } catch (e) {
      console.log(e);
    }
  },
};
</script>

<style scoped>
.my-event {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  border-radius: 2px;
  background-color: #78c4d4;
  color: #ffffff;
  border: 1px solid #78c4d4;
  font-size: 12px;
  padding: 3px;
  cursor: pointer;
  margin-bottom: 1px;
  left: 4px;
  margin-right: 8px;
  position: relative;
}

.my-event.with-time {
  position: absolute;
  right: 4px;
  margin-right: 0px;
}

.scheduled:hover {
  background-color: #c0e4ec;
}
</style>

