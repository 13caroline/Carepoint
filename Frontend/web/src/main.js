import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from './router'
import store from './store'
import snackbarPlugin from './plugins/snackbar';
import '@fortawesome/fontawesome-free/css/all.css'

Vue.config.productionTip = false
Vue.use(snackbarPlugin, { store })

new Vue({
  iconfont: 'fa',
  vuetify,
  router,
  store,
  render: h => h(App)
}).$mount('#app')
