<template>
  <v-row>
    <v-col>
      <v-sheet height="64">
        <v-toolbar flat>
          <v-spacer></v-spacer>
          <v-menu bottom right>
            <template v-slot:activator="{ on, attrs }">
              <v-btn outlined color="grey darken-2" v-bind="attrs" v-on="on">
                <span>{{ cat[type] }}</span>
                <v-icon right> mdi-menu-down </v-icon>
              </v-btn>
            </template>
            <v-list>
              <v-list-item @click="type = 'day'">
                <v-list-item-title>Day</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'week'">
                <v-list-item-title>Week</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'month'">
                <v-list-item-title>Month</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = '4day'">
                <v-list-item-title>4 days</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-toolbar>
      </v-sheet>
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
    </v-col>
  </v-row>
</template>

<script>
import moment from "moment";
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
  }),
  mounted() {
    this.$refs.calendar.scrollToTime("08:00");
  },
  methods: {
    getEventColor(event) {
      return event.occupied == 0 ? "#78C4D4" : "#BDBDBD";
    },
  },
  created() {
      for (var j = 0; j < this.dados.length; j++) {
        this.cat.push(this.dados[j].name);
      }

      let schedule = this.dados[0].workSchedule;
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