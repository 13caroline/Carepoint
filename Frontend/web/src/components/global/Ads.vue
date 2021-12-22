<template>
  <v-item-group>
    <v-row>
      <v-col
        cols="auto"
        lg="4"
        md="4"
        class="mx-auto mx-sm-0"
        v-for="a in ads"
        :key="a.name"
      >
        <div class="user">
          <!--<img
            aspect-ratio="1"
            src="@/assets/userImgTest.jpg"
            class="w-100 grey lighten-2 rounded"
          />
          <v-tooltip top>
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                class="mt-2 w-100"
                text
                outlined
                v-bind="attrs"
                v-on="on"
                small
                id="no-background-hover"
              >
                {{ a.name }}
              </v-btn>
            </template>
            <span class="caption">Ver Mais</span>
          </v-tooltip>-->
          <v-card
            class="card rounded-xl overflow-auto"
            outlined
            tile
            :style="styleObject"
            height="400"
            width="300"
          >
            <v-card-text>
              <span class="activity d-flex justify-end pb-2"
                >última vez ativo há {{ a.activity }}</span
              >
              <v-row justify="center">
                <v-col cols="auto">
                  <v-avatar class="profile" color="grey" size="100">
                    <v-img src="@/assets/userImgTest.jpg"></v-img>
                  </v-avatar>
                </v-col>
              </v-row>

              <v-row justify="center" class="mx-auto">
                <span class="indication font-weight-bold">
                  {{ a.name }}
                </span>
              </v-row>

              <v-row justify="center" class="mx-auto">
                <span class="indication">
                  {{ a.localization }}
                </span>
              </v-row>

              <v-divider class="mx-4 mt-5"></v-divider>

              <v-row justify="center" class="mx-auto">
                <span class="description">
                  {{ a.description }}
                </span>
              </v-row>
            </v-card-text>
          </v-card>
        </div>
      </v-col>
    </v-row>
  </v-item-group>
</template>

<script>
export default {
  name: "Ads",

  data() {
    return {
      styleObject: { border: "1px solid #78C4D4" },
      ads: [
        {
          name: "Carolina Cunha",
          activity: "2 dias",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          localization: "Fafe",
        },
        {
          name: "Carolina Cunha",
          activity: "5 minutos",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          localization: "Fafe",
        },
        {
          name: "Carolina Cunha",
          activity: "2 dias",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          localization: "Fafe",
        },
        {
          name: "Carolina Cunha",
          activity: "2 dias",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          localization: "Fafe",
        },
        {
          name: "Carolina Cunha",
          activity: "2 dias",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          localization: "Fafe",
        },
        {
          name: "Carolina Cunha",
          activity: "2 dias",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consequat.",
          localization: "Fafe",
        },
      ],
    };
  },
};
</script>

<style scoped>
.user {
  width: 100%;
}

.round {
  border-radius: 100%;
}

.indication {
  text-align: center;
  color: #78c4d4;
}

.description {
  text-align: justify;
  text-justify: auto;
  color: grey;
  margin-top: 2em;
}

.activity {
  font-size: smaller;
}
</style>