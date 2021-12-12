import Vue from 'vue'
import Vuex from 'vuex'

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
  },
  getters: {
    links: state => {
      return state.items
    },
  },
  mutations: {
    setDrawer: (state, payload) => (state.drawer = payload),
    toggleDrawer: state => (state.drawer = !state.drawer),
  },
  actions: {

  },
})
