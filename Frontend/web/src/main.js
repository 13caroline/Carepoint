import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from './router'
import store from './store'
import snackbarPlugin from './plugins/snackbar';
import '@fortawesome/fontawesome-free/css/all.css'
import Chat from 'vue-beautiful-chat'


Vue.config.productionTip = false
Vue.use(snackbarPlugin, { store}, Chat)


new Vue({
  iconfont: 'fa',
  vuetify,
  router,
  store,
  render: h => h(App)
}).$mount('#app')
