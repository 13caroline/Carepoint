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
    path: '/register/subscription/:id',
    name: 'Subscription',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/Subscription.vue')
  },
  {
    path: '/consumer/profile',
    name: 'profile',
    component: () => import('../views/global/Profile.vue')
  },
  {
    path: '/consumer/page',
    name: 'Consumer Profile',
    component: () => import(/* webpackChunkName: "about" */'../views/profile/MainConsumer.vue')
  },
  {
    path: '/consumer/post/ad',
    name: 'Post Ad',
    component: () => import('../views/global/PostAd.vue')
  },
  {
    path: '/consumer/edit/profile',
    name: 'Edit Profile',
    component: () => import('../views/global/EditData.vue')
  },
  {
    path: '/ad/info',
    name: 'Ad Info',
    component: () => import('../views/global/AdInfo.vue')
  },
  {
    path: '/consumer/become/service/provider',
    name: 'Become Service Provider',
    component: () => import('../views/global/BecomeSP.vue')
  },
  {
    path: '/consumer/my/advirtisements',
    name: 'My advertisements',
    component: () => import('../views/global/MyAdvertisements')
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