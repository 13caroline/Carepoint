<template>
  <div>
    <v-row justify="end" v-if="$store.state.tipo == 3">
      <v-col cols="auto">
        <NewSlot @clicked="updated"></NewSlot>
      </v-col>
    </v-row>
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
          :event-color="getEventColor"
          @click:event="showEvent"
        >
          <template v-slot:day-label-header="{}">-</template>
        </v-calendar>
        <small v-else> <em> não existem horários registados </em></small>
        <v-menu
          v-if="$store.state.tipo == 3"
          v-model="selectedOpen"
          :close-on-content-click="false"
          :activator="selectedElement"
          offset-x
          max-width="500px"
        >
          <v-card color="grey lighten-4" flat>
            <v-card-text>
              <v-row>
                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Nome do Animal</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ selectedEvent.utente }}</strong>
                    ({{ selectedEvent.raca }})
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Motivo da consulta</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ selectedEvent.details }}</strong>
                  </span>
                  <br />
                  <span>{{ selectedEvent.desc }}</span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Data</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <!--<span class="black--text">
                    <strong
                      >{{ format(selectedEvent.start) }} -
                      {{ format(selectedEvent.end) }}</strong
                    >
                  </span>-->
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">estado</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <v-chip :color="colors" small>
                    {{ selectedEvent.state }}
                  </v-chip>
                </v-col>
              </v-row>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-tooltip top v-if="selectedEvent.state == 'A decorrer'">
                <template v-slot:activator="{ on, attrs }">
                  <v-icon
                    color="#66BB6A"
                    v-bind="attrs"
                    v-on="{ on }"
                    @click="confirmar('Concluída')"
                  >
                    mdi-calendar-check
                  </v-icon>
                </template>
                <span class="caption">Concluir consulta</span>
              </v-tooltip>
              <v-tooltip
                top
                v-if="
                  selectedEvent.state == 'Agendada' ||
                  selectedEvent.state == 'Pendente'
                "
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-icon
                    color="#E57373"
                    v-bind="attrs"
                    v-on="{ on }"
                    @click="confirmar('Cancelada')"
                  >
                    mdi-calendar-remove
                  </v-icon>
                </template>
                <span class="caption">Cancelar agendamento</span>
              </v-tooltip>
            </v-card-actions>
          </v-card>
        </v-menu>
      </v-sheet>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  props: ["dados"],
  data: () => ({
    today: "2022-01-03",
    events: [],
    start: null,
    end: null,
    occupied: null,
    name: null,
    weekday: [1, 2, 3, 4, 5, 6, 0],
    type: "",
    cat: [],
    schedules: {},
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
  }),
  mounted() {
    this.$refs.calendar.scrollToTime("08:00");
  },
  components: {
    NewSlot: () => import("@/components/dialogs/NewSlot"),
  },
  methods: {
    getEventColor(event) {
      var color = "#78C4D4";
      if (event.occupied == 1) return "#D7CCC8";
      else {
        switch (event.category) {
          case "Companhia":
            color = "#D7BFDC";
            break;
          case "Compras":
            color = "#FDA172";
            break;
          case "Medicação":
            color = "#F5C3C2";
            break;
          case "Higiene":
            color = "#95C8D8";
            break;
          case "Passeios":
            color = "#C5E1A5";
            break;
          case "Refeições":
            color = "#EEDC82";
            break;
        }
        return color;
      }
    },
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event;
        this.colors = this.getEventColor(event);
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
    categorySchedule(value) {
      this.events = [];
      var found = this.received.find((e) => e.name === value);

      let workSchedule = found.workSchedule;
      for (var i = 0; i < workSchedule.length; i++) {
        this.events.push({
          start: workSchedule[i].date_begin,
          end: workSchedule[i].date_end,
          occupied: 0,
          category: found.name,
        });
      }

      let occupiedSchedule = found.occupiedSchedule;
      for (var k = 0; k < occupiedSchedule.length; k++) {
        this.events.push({
          start: occupiedSchedule[k].date_begin,
          end: occupiedSchedule[k].date_end,
          occupied: 1,
          category: found.name,
        });
      }
    },
    updated: async function () {
      this.events = [];
      try {
        let response = await axios.get(
          "http://localhost:9040/serviceProvider/horarios/?id=" + this.dados
        );
        console.log(response.data);
        let workSchedule = null;
        let occupiedSchedule = null;
        if (response.data.categories) {
          workSchedule = response.data.categories[0].workSchedule;
          if (workSchedule) {
            for (var i = 1; i < workSchedule.length; i++) {
              this.events.push({
                start: workSchedule[i].date_begin,
                end: workSchedule[i].date_end,
                occupied: 0,
              });
            }
          }

          occupiedSchedule = response.data.categories[0].occupiedSchedule;
          if (occupiedSchedule) {
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
  },
  created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/serviceProvider/horarios/?id=" + this.dados
      );
      console.log(response.data);
      let workSchedule = null;
      let occupiedSchedule = null;
      if (response.data.categories.length) {
        workSchedule = response.data.categories[0].workSchedule;

        for (var i = 1; i < workSchedule.length; i++) {
          this.events.push({
            start: workSchedule[i].date_begin,
            end: workSchedule[i].date_end,
            occupied: 0,
          });
        }

        occupiedSchedule = response.data.categories[0].occupiedSchedule;
        for (var k = 0; k < occupiedSchedule.length; k++) {
          this.events.push({
            start: occupiedSchedule[k].date_begin,
            end: occupiedSchedule[k].date_end,
            occupied: 1,
          });
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
  background-color: #1867c0;
  color: #ffffff;
  border: 1px solid #1867c0;
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
</style>

