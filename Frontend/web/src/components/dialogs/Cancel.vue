<template>
  <div>
    <v-dialog v-model="dialog" persistent width="100%" max-width="460">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          dense
          color="#78c4d4"
          class="rounded-lg"
          outlined
          background-color="white"
          required
          v-bind="attrs"
          v-on="on"
        >
          Cancelar
        </v-btn>
      </template>
      <v-card>
        <v-card-title id="card-title" class="justify-center cancel">
          Cancelar {{ dialogs.title }}
        </v-card-title>
        <v-card-text>
          Tem a certeza que pretende cancelar {{ dialogs.text }}?
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            depressed
            large
            outlined
            width="50%"
            dark
            color="#78c4d4"
            @click="dialog = false"
          >
            Não
          </v-btn>
          <v-btn
            depressed
            large
            dark
            color="#78c4d4"
            width="50%"
            @click="close()"
          >
            Sim
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  props: ["dialogs"],
  data: () => ({
    dialog: false,
  }),
  methods: {
    close() {
      (this.dialog = false), this.$emit("clicked", "cancel");
    },
  },
};
</script>

<style>
  #card-title {
    word-break: keep-all;
  };
</style>
