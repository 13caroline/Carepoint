import Vue from 'vue'
import VueRouter from 'vue-router'
//import store from '../store'

Vue.use(VueRouter)

const routes = [
  //------------------------------------- Cliente -------------------------------------
  {
    path: '/',
    name: 'Home',
    component: () => import(/* webpackChunkName: "about" */ '../views/HomePage.vue')
  },
  {
    path: '/register/type',
    name: 'Type User',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/UserTypeView.vue')
  },
  {
    path: '/register/provider/solo',
    name: 'Solo Service Provider Register',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/SingleSP.vue')
  },
  {
    path: '/register/provider/collective',
    name: 'Collective Service Provider Register',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/CollectiveSP.vue')
  },
  {
    path: '/register/consumer',
    name: 'Consumer',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/Consumer.vue')
  },
  {
    path: '/global/profile',
    name: 'profile',
    component: () => import('../views/global/Profile.vue')
  },
  {
    path: '/consumer/profile',
    name: 'Consumer Profile',
    component: () => import(/* webpackChunkName: "about" */'../views/profile/MainConsumer.vue')
  }
]

const router = new VueRouter({
  mode: 'hash',
  base: process.env.BASE_URL,
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
})

export default router