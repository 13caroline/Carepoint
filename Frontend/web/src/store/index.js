import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    items: [
      {
        text: 'Iniciar Sessão',
        href: '#!',
      },
      {
        text: 'Prestadores de Cuidados',
        href: '#careproviders',
      },
      {
        text: 'Sobre',
        href: '#about',
      },
    ],
    token: "",
    tipo: "",
    snackbar: {
      text: "",
      color: "",
      timeout: "",
    },
    subType: 0, 
    subPrice: 0,
    subSubscription: 0,
  },
  plugins: [createPersistedState()],
  getters: {
    links: state => {
      return state.items
    },
    tipo: state => state.tipo,
    token: state => state.token,
    isAuthenticated: state => !!state.token,
    authStatus: state => state.status,
    subType: state => state.subType,
    subPrice: state => state.subPrice,
    subSubscription: state => state.subSubscription,
  },
  mutations: {
    setDrawer: (state, payload) => (state.drawer = payload),
    toggleDrawer: state => (state.drawer = !state.drawer),
    guardaTokenUtilizador(state, token) {
      state.token = token;
    },
    guardaTipoUtilizador(state, tipo) {
      state.tipo = tipo;
    },
    guardaSubType(state, type){
      state.subType = type;
    },
    subPrice(state, price){
      state.subPrice = price;
    },
    subSubscription(state, subscription){
      state.subSubscription = subscription;
    },
    limpaStore(state) {
      state.token = "";
      state.tipo = "";
    },
    showMessage(state, payload) {
      state.snackbar.text = payload.text;
      state.snackbar.color = payload.color;
      state.snackbar.timeout = payload.timeout;
    },
    limpaSubscription(state) {
      state.subscription.type = 0;
      state.subscription.price = 0;
      state.subscription.subscription = 0;
    },
  },
  actions: {

  },
})
