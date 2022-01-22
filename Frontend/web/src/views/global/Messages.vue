<template>
  <div>
    <Bar />
    <v-container>
      <v-row no-gutters class="w-100">
        <v-col cols="3">
          <v-card class="mx-auto h-100" style="height: 98vh">
            <v-list subheader>
              <v-subheader>Prestadores de Serviços</v-subheader>
              <v-list-item
                v-for="item in users"
                :key="item.title"
                @click="openChat(item.idUser)"
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
          <v-card class="mx-auto h-100" style="height:98vh">
            <v-row justify="end">
              <v-col>
            <v-list rounded>
              <v-subheader>REPORTS</v-subheader>
              <v-list-item-group color="primary">
                <v-list-item
                  v-for="(item, i) in messages"
                  :key="i"
                  :class="item.sent ? 'text-right' : ''"
                >
                  <v-chip pill v-if="item.idReceive==53">
                    {{ item.content }}
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
                    append-outer-icon="mdi-send"
                    @click:append-outer="send"
                    v-model="messageNew.text"
                    class="mx-2"
                    label="Mensagem"
                    rows="2"
                  ></v-textarea>
                </v-list-item>
              </v-list-item-group>
            </v-list>
            </v-col>
            </v-row>
          </v-card>
        </v-col>-->
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
    messages:{},
    activeUser:0,
    idUser: 0,
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
    messages2: [
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
  components: {
    Bar: () => import("@/components/global/AppBarAccount.vue"),
    Foot: () => import("@/components/global/Footer"),

  },
  methods: {
    send: async function () {
      if (this.$refs.form.validate()) {
        try {
          console.log(this.dados);
          await axios.post("http://localhost:9040/message/addMessage", {
            token: store.getters.token,
            content: this.form.description,
            idUser2: this.dados,
          });
          this.$emit("clicked", "update");
          (this.dialog = false),
            this.$snackbar.showMessage({
              show: true,
              text: "Mensagem enviada com sucesso.",
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

    doSomething() {
      console.log("Do something");
    },
    openChat(idUser){
      this.activeUser=idUser;
      this.showChats();

    },
    showChats: async function(){
      try {
      let response = await axios.post(
        "http://localhost:9040/message/seeUsers",
        {
          token: store.getters.token,
        }
      );
      console.log(response.data);
      this.users = response.data;
      console.log("current user: " +this.users[0].idUser)
      console.log("active user: "+this.activeUser)
      if(this.activeUser!=0)
      this.getMessage(this.activeUser)
      else this.getMessage(this.users[0].idUser)
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
      console.log(idReceiver);
      try {
        let response = await axios.post(
          "http://localhost:9040/message/seeMessages",
          {
            token: store.getters.token,
            idUser2: idReceiver,
          }
        );
        console.log(response.data);
        this.messages = response.data;
        if(this.messages[0]==idReceiver) this.idUser=this.messages[0].idGive
        else this.idUser=this.messages[0].idReceive
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
