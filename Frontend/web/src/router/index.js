import Vue from 'vue'
import VueRouter from 'vue-router'
//import store from '../store'

Vue.use(VueRouter)

const routes = [
  
  {
    path: '/',
    name: 'Home',
    component: () => import(/* webpackChunkName: "about" */ '../views/HomePage.vue')
  },

  //------------------------------------- REGISTER -------------------------------------

  // User Type 
  {
    path: '/register/type',
    name: 'Type User',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/UserTypeView.vue')
  },

  // Register Single Service Provider
  {
    path: '/register/provider/solo',
    name: 'Solo Service Provider Register',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/SingleSP.vue')
  },

  // Register Collective Service Provider
  {
    path: '/register/provider/collective',
    name: 'Collective Service Provider Register',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/CollectiveSP.vue')
  },

  // Register Consumer
  {
    path: '/register/consumer',
    name: 'Consumer',
    component: () => import(/* webpackChunkName: "about" */ '../views/register/Consumer.vue')
  },

  // Register Subscription
  {
    path: '/register/subscription/:id',
    name: 'Subscription',
    component: () => import(/* webpackChunkName: "about" */ '../views/subscription/Subscription.vue')
  },

  // Consumer data
  {
    path: '/consumer/profile',
    name: 'profile',
    component: () => import('../views/global/Profile.vue')
  },

 
  {
    path: '/consumer/edit/profile',
    name: 'Edit Profile',
    component: () => import('../views/global/EditData.vue')
  },
  {
    path: '/ad/info/:id',
    name: 'Ad Info',
    component: () => import('../views/ads/AdInfo.vue')
  },
  


  //------------------------------------- CONSUMER -------------------------------------

  // Become a Service Provider
  {
    path: '/consumer/become/service/provider',
    name: 'Become Service Provider',
    component: () => import('../views/consumer/BecomeSP.vue')
  },

  // Consumer's page
  {
    path: '/consumer/page',
    name: 'Consumer Profile',
    component: () => import(/* webpackChunkName: "about" */'../views/consumer/ConsumerPage.vue')
  },

  // Consumer's advertisements
  {
    path: '/consumer/my/advirtisements',
    name: 'My advertisements',
    component: () => import('../views/consumer/MyAdvertisements')
  },

  // Post an ad
  {
    path: '/consumer/post/ad',
    name: 'Post Ad',
    component: () => import('../views/consumer/PostAd.vue')
  },

  // Service Providers profile
  {
    path: '/service/provider/page',
    name: 'SP Profile',
    component: () => import('../views/serviceProviders/Profile.vue')
  },
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