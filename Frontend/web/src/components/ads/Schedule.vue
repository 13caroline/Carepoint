<template>
  <div>
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
import axios from "axios";
export default {
  props: ["dados"],
  data: () => ({
    selectedDefault: "",
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
  }),
  mounted() {
    this.$refs.calendar.scrollToTime("08:00");
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
  },

  created: async function () {
    try {
      let response = await axios.get(
        "http://localhost:9040/serviceProvider/horarios/?id=" + this.dados
      );
      if (response.data.categories){ 
        let workSchedule = response.data.categories[0].workSchedule;

        for (var i = 0; i < workSchedule.length; i++) {
          this.events.push({
            start: workSchedule[i].date_begin,
            end: workSchedule[i].date_end,
            occupied: 0,
          });
        }

        let occupiedSchedule = response.data.categories[0].occupiedSchedule;
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

