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
    limpaStore(state) {
      state.token = "";
      state.tipo = "";
    },
    showMessage(state, payload) {
      state.snackbar.text = payload.text;
      state.snackbar.color = payload.color;
      state.snackbar.timeout = payload.timeout;
    },
  },
  actions: {

  },
})
