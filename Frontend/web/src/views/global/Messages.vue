<template>
  <div>
    <Bar />
    <v-container>
      <v-row no-gutters class="w-100">
        <v-col cols="3">
          <v-card class="mx-auto h-100" style="height: 98vh">
            <v-list subheader>
              <v-subheader>Prestadores de Serviços</v-subheader>
                  <v-list-item-group
        active-class="light-blue lighten-4"
      >
              <v-list-item
                v-for="item in users"
                :key="item.title"
                @click="openChat(item)"
              >
                <v-list-item-avatar>
                  <v-img :src="processImage(item.image)"></v-img>
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title v-text="item.title"></v-list-item-title>
                </v-list-item-content>
                <v-list-item-icon>
                  <v-icon
                    :color="item.active ? 'deep-purple accent-4' : 'grey'"
                    >{{ item.name }}</v-icon
                  >
                </v-list-item-icon>
              </v-list-item>
                  </v-list-item-group>
            </v-list>
            <!--<v-divider></v-divider>
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
            </v-list>-->
          </v-card>
        </v-col>

        <v-col cols="9">
          <v-card class="mx-auto h-100" style="height: 98vh">
            <v-row justify="end">
              <v-col>
                <v-list disabled rounded>
                  <v-list-item-group color="primary">
                    <v-list-item
                      v-for="(item, i) in messages"
                      :key="i"
                      :class="item.sent ? 'text-right' : ''"
                      class="text-right align-self-start"
                    >
                      <v-avatar size="36" v-if="item.idReceive == idUser">
                        <v-img :src="processImage(pic)"></v-img>
                      </v-avatar>
                      <v-chip
                      class="pa-6"
                        pill
                        v-if="item.idReceive == idUser"
                        color="#c0e4ec"
                      >
                        {{ item.content }}
                      </v-chip>
                      <v-row v-else>
                        <v-col>
                          <v-chip pill class="pa-6">
                            {{ item.content }}
                          </v-chip>
                        </v-col>
                      </v-row>
                    </v-list-item>
                  </v-list-item-group>
                </v-list>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
            <v-textarea
              append-outer-icon="mdi-send"
              @click:append-outer="send(activeUser)"
              v-model="messageNew.text"
              class="mx-5"
              label="Mensagem"
              rows="1"
              outlined
            ></v-textarea>
            </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <Foot />
  </div>
</template>

<script>
import axios from "axios";
import store from "@/store/index.js";

export default {
  data: () => ({
    users: {},
    messages: {},
    activeUser: 0,
    idUser: 0,
    pic: [],
    messageNew: {
      text: null,
    },
    user_item: 0,
  }),
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),
  },
  methods: {
    send: async function (receiver) {
        try {
          console.log("Receiver: " + receiver);
          console.log("Content: " + this.messageNew.text);
          await axios.post("http://localhost:9040/message/addMessage", {
            token: store.getters.token,
            content: this.messageNew.text,
            idUser2: receiver,
          });
            this.showChats();
            this.messageNew.text=""
           
        } catch (e) {
          this.$snackbar.showMessage({
            show: true,
            color: "warning",
            text: "Ocorreu um erro, por favor tente mais tarde!",
            timeout: 4000,
          });
        }

    },

    openChat(item) {
      this.activeUser = item.idUser;
      this.pic = item.image;
      this.showChats();
    },
    showChats: async function () {
      try {
        let response = await axios.post(
          "http://localhost:9040/message/seeUsers",
          {
            token: store.getters.token,
          }
        );
        this.users = response.data;
        
        if (this.activeUser != 0) this.getMessage(this.activeUser);
        else{
          this.activeUser=response.data[0].idUser;
        this.pic = response.data[0].image;
         this.getMessage(this.users[0].idUser);
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
    processImage(img) {
      return (
        "data:image/png;base64," +
        btoa(String.fromCharCode.apply(null, new Uint8Array(img.data)))
      );
    },
    getMessage: async function (idReceiver) {
      try {
        let response = await axios.post(
          "http://localhost:9040/message/seeMessages",
          {
            token: store.getters.token,
            idUser2: idReceiver,
          }
        );
       
        this.messages = response.data;
        if (this.messages[0].idReceive == idReceiver)
          this.idUser = this.messages[0].idGive;
        else this.idUser = this.messages[0].idReceive;
      } catch (e) {
        this.$snackbar.showMessage({
          show: true,
          color: "error",
          text: "Ocorreu um erro. Por favor tente mais tarde!",
          timeout: 4000,
        });
      }
    },
  },
  created: async function () {
    this.showChats();
  },
};
</script>

<style scoped>
.v-chip{
  height: auto; 
  white-space: normal;
}
</style>