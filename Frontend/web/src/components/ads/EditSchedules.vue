<template>
  <div>
    <v-row justify="end" class="mt-2">
      <v-col cols="auto">
        <EditCategories @clicked="updated"></EditCategories>

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
                  <span class="text-uppercase">Data início</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ selectedEvent.start }}</strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Data término</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ selectedEvent.end }}</strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5">
                  <span class="text-uppercase">Estado</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7">
                  <span class="black--text">
                    <strong>{{ getEventState(selectedEvent) }}</strong>
                  </span>
                </v-col>

                <v-col class="pb-0" align="right" cols="5" v-if="selectedEvent.occupied == 1">
                  <span class="text-uppercase" >Categorias</span>
                </v-col>
                <v-col class="pl-0 pb-0" cols="7" v-if="selectedEvent.occupied == 1">
                  <v-chip
                    class="black--text"
                    small
                    v-for="c in selectedEvent.categories"
                    :key="c.idCategory"
                  >
                    {{ getCategory(c) }}
                  </v-chip>
                </v-col>
              </v-row>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-tooltip top>
                <template v-slot:activator="{ on, attrs }">
                  <v-icon
                    color="#E57373"
                    v-bind="attrs"
                    v-on="{ on }"
                    @click="remove(selectedEvent)"
                  >
                    mdi-calendar-remove
                  </v-icon>
                </template>
                <span class="caption">Remover slot</span>
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
import store from "@/store/index.js";
export default {
  props: ["dados"],
  data: () => ({
    today: "2022-01-03",
    events: [],
    start: null,
    end: null,
    occupied: null,
    name: null,
    id: null,
    requested: null,
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
    EditCategories: () => import("@/components/dialogs/EditCategories"),
  },
  methods: {
    getEventColor(event) {
      var color = "";
      event.occupied == 1 ? (color = "#D7CCC8") : (color = "#78C4D4");

      return color;
    },

    getEventState(event){
      let state = "";
      event.occupied == 1 ? state = "Ocupado" : state = "Livre"

      return state;
    },

    getCategory(event) {
      return this.cat[event - 1].name;
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
    remove: async function (event) {
      try {
        await axios.put("http://localhost:9040/serviceProvider/remSlot", {
          token: store.getters.token,
          id: event.id,
          dateEnd: event.end,
          occupied: event.occupied,
          dateBegin: event.start,
          postDate: event.requested,
          categories: event.categories,
        });
        this.updated();
        this.$snackbar.showMessage({
          show: true,
          text: "Slot removido com sucesso.",
          color: "success",
          snackbar: true,
          timeout: 4000,
        });
      } catch (e) {
        console.log(e);
        this.$snackbar.showMessage({
          show: true,
          color: "warning",
          text: "Ocorreu um erro no processamento, por favor tente mais tarde!",
          timeout: 4000,
        });
      }

      try {
        let response3 = await axios.get("http://localhost:9040/category");
        if (response3) {
          this.cat = response3.data;
        }
      } catch (e) {
        console.log(e);
      }
    },

    updated: async function () {
      this.events = [];
      try {
        let response = await axios.get(
          "http://localhost:9040/serviceProvider/horarios/?id=" + this.dados
        );
        let workSchedule = null;
        let occupiedSchedule = null;
        if (response.data.categories) {
          workSchedule = response.data.categories[0].workSchedule;
          if (workSchedule) {
            for (var i = 0; i < workSchedule.length; i++) {
              this.events.push({
                start: workSchedule[i].date_begin,
                end: workSchedule[i].date_end,
                occupied: 0,
              });
            }
          }

          occupiedSchedule = response.data.categories[0].occupiedSchedule;
          if (occupiedSchedule) {
            for (var k = 0; k < occupiedSchedule.length; k++) {
              this.events.push({
                start: occupiedSchedule[k].date_begin,
                end: occupiedSchedule[k].date_end,
                occupied: 1,
                categories: occupiedSchedule[k].idCategory,
                id: occupiedSchedule[k].id,
                requested: occupiedSchedule[k].date_requested,
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
        if (workSchedule) {
          for (var i = 0; i < workSchedule.length; i++) {
            this.events.push({
              start: workSchedule[i].date_begin,
              end: workSchedule[i].date_end,
              occupied: 0,
            });
          }
        }

        occupiedSchedule = response.data.categories[0].occupiedSchedule;
        if (occupiedSchedule) {
          for (var k = 0; k < occupiedSchedule.length; k++) {
            if (occupiedSchedule[k].occupied == "1")
              this.events.push({
                start: occupiedSchedule[k].date_begin,
                end: occupiedSchedule[k].date_end,
                occupied: 1,
                categories: occupiedSchedule[k].idCategory,
                id: occupiedSchedule[k].id,
                requested: occupiedSchedule[k].date_requested,
              });
          }
        }
      }
    } catch (e) {
      console.log(e);
    }

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

