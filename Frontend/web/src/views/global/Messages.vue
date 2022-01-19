<template>
  <div id="app">
    <v-container>
      <v-row no-gutters class="w-100">
        <v-col cols="3">
          <v-card class="mx-auto h-100" style="height:98vh">
            <v-list subheader>
              <v-subheader>Recent chat</v-subheader>
              <v-list-item
                v-for="item in items"
                :key="item.title"
                @click="doSomething()"
              >
                <v-list-item-avatar>
                  <v-img :src="item.avatar"></v-img>
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title v-text="item.title"></v-list-item-title>
                </v-list-item-content>
                <v-list-item-icon>
                  <v-icon :color="item.active ? 'deep-purple accent-4' : 'grey'"
                    >chat_bubble</v-icon
                  >
                </v-list-item-icon>
              </v-list-item>
            </v-list>
            <v-divider></v-divider>
            <v-list subheader>
              <v-subheader>Previous chats</v-subheader>
              <v-list-item
                v-for="item in items2"
                :key="item.title"
                @click="doSomething()"
              >
                <v-list-item-avatar>
                  <v-img :src="item.avatar"></v-img>
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title v-text="item.title"></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </v-card>
        </v-col>

        <v-col cols="9">
          <v-card class="mx-auto h-100" style="height:98vh">
            <v-list rounded>
              <v-subheader>REPORTS</v-subheader>
              <v-list-item-group color="primary">
                <v-list-item
                  v-for="(item, i) in messages"
                  :key="i"
                  :class="item.sent ? 'text-right' : ''"
                >
                  <v-chip pill v-if="item.sent">
                    {{ item.msg }}
                    <v-avatar right>
                      <v-img
                        src="https://cdn.vuetifyjs.com/images/john.png"
                      ></v-img>
                    </v-avatar>
                  </v-chip>
                  <v-chip pill v-else>
                    <v-avatar left>
                      <v-img
                        src="https://cdn.vuetifyjs.com/images/john.png"
                      ></v-img>
                    </v-avatar>
                    {{ item.msg }}
                  </v-chip>
                </v-list-item>
                <v-list-item>
                  <v-textarea
                    append-outer-icon="send"
                    @click:append-outer="sendMessage"
                    v-model="messageNew.text"
                    class="mx-2"
                    label="Message to send"
                    rows="2"
                  ></v-textarea>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  data: () => ({
    items: [
      {
        active: true,
        title: "Jason Oner",
        avatar: "https://cdn.vuetifyjs.com/images/lists/1.jpg",
      },
      {
        active: true,
        title: "Ranee Carlson",
        avatar: "https://cdn.vuetifyjs.com/images/lists/2.jpg",
      },
      {
        title: "Cindy Baker",
        avatar: "https://cdn.vuetifyjs.com/images/lists/3.jpg",
      },
      {
        title: "Ali Connors",
        avatar: "https://cdn.vuetifyjs.com/images/lists/4.jpg",
      },
    ],
    items2: [
      {
        title: "Travis Howard",
        avatar: "https://cdn.vuetifyjs.com/images/lists/5.jpg",
      },
    ],
    messageNew: {
      text: null,
    },
    messages: [
      {
        msg: "Real-Time",
        avatar: "https://cdn.vuetifyjs.com/images/john.png",
        sent: false,
      },
      {
        msg: "Audience",
        avatar: "https://cdn.vuetifyjs.com/images/john.png",
        sent: true,
      },
      {
        msg: "Conversions",
        avatar: "https://cdn.vuetifyjs.com/images/john.png",
        sent: false,
      },
      {
        msg: "reaas",
        avatar: "https://cdn.vuetifyjs.com/images/john.png",
        sent: false,
      },
    ],

    user_item: 0,
    user_items: [
      { text: "My Files", icon: "mdi-folder" },
      { text: "Shared with me", icon: "mdi-account-multiple" },
      { text: "Starred", icon: "mdi-star" },
      { text: "Recent", icon: "mdi-history" },
      { text: "Offline", icon: "mdi-check-circle" },
      { text: "Uploads", icon: "mdi-upload" },
      { text: "Backups", icon: "mdi-cloud-upload" },
    ],
  }),
  methods: {
    sendMessage() {
      this.messages.push({
        msg: this.messageNew.text,
        avatar: "https://cdn.vuetifyjs.com/images/john.png",
        sent: true,
      });
      this.messageNew.text = null;
    },
    doSomething() {
      console.log("Do something");
    },
  },
};
</script>
