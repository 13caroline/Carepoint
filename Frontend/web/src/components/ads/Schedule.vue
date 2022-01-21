<template>
  <div>
    <div>
      <v-sheet height="64">
        <v-spacer></v-spacer>
        <v-select
          v-model="search"
          append-icon="mdi-magnify"
          label="Categoria"
          outlined
          dense
          color="#78C4D4"
          :items="received"
          item-text="name"
          item-value="id"
          hide-details
          @change="categorySchedule"
          no-data-text="Sem categorias registadas"
        ></v-select>
      </v-sheet>
    </div>
    <div>
      <v-sheet height="600">
        <v-calendar
          ref="calendar"
          :start="today"
          :events="events"
          color="#78C4D4"
          type="week"
          :weekdays="weekday"
          locale="PT"
          :event-color="getEventColor"
        >
          <template v-slot:day-label-header="{}">-</template>
        </v-calendar>
      </v-sheet>
    </div>
  </div>
</template>

<script>
import axios from "axios"
import moment from "moment";
export default {
  props: ["dados"],
  data: () => ({
    search: "",
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
    received: []
  }),
  mounted() {
    this.$refs.calendar.scrollToTime("08:00");
  },
  methods: {
    getEventColor(event) {
      return event.occupied == 0 ? "#78C4D4" : "#BDBDBD";
    },
    categorySchedule(value) {
      this.events = [];
      var found = this.received.find((e) => e.name === value);

      let schedule = found.workSchedule;
      for (var i = 0; i < schedule.length; i++) {
        let state = schedule[i].occupied == 0 ? "Livre" : "Preenchido";

        this.events.push({
          start: schedule[i].date,
          occupied: schedule[i].occupied,
          end: moment(schedule[i].date).add(30, "m").format("YYYY-MM-DD HH:mm"),
          name: state,
        });
      }
    },
  },
  
  created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/serviceProvider/horarios/?id=" + this.dados
      );
    this.received = response.data.categories;
    for (var j = 0; j < this.received.length; j++) {
      let schedule = this.received[j].workSchedule;
      for (var i = 0; i < schedule.length; i++) {
        let state = schedule[i].occupied == 0 ? "Livre" : "Preenchido";

        this.events.push({
          start: schedule[i].date,
          occupied: schedule[i].occupied,
          end: moment(schedule[i].date).add(30, "m").format("YYYY-MM-DD HH:mm"),
          name: state,
        });
      }
    }

     } catch (e) {
      this.$snackbar.showMessage({
        show: true,
        color: "error",
        text: "Ocorreu um erro. Por favor tente mais tarde!",
        timeout: 4000,
      });
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