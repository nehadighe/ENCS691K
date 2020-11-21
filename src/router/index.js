import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store/store';

Vue.use(VueRouter)

const routes = [
  {
    path: '/test',
    name: 'test',
    component: () => import(/* webpackChunkName: "about" */ '../views/Test.vue')
  },
  {
    path: '/auth',
    name: 'auth',
    component: () => import(/* webpackChunkName: "about" */ '../views/Auth.vue'),
    // beforeEnter: (to, from, next) => {
    //   if (store.state.authUser.authenticated) {
    //     next({
    //       path: '/',
    //       name: 'home',
    //       component: () => import('../views/Home.vue')
    //     })
    //   }
    //   else {
    //     next()
    //   }
    // }
  },
  {
    path: '/user/items',
    name: 'userItem',
    component: () => import(/* webpackChunkName: "about" */ '../views/UserItem.vue'),
    beforeEnter: (to, from, next) => {
      if (!store.state.authUser.authenticated) {
        next({
          path: '/auth',
          name: 'auth',
          component: () => import('../views/Auth.vue')
        })
      }
      else {
        next()
      }
    }
  },
  {
    path: '/user/bought',
    name: 'userBoughtItem',
    component: () => import(/* webpackChunkName: "about" */ '../views/UserBoughtItem.vue'),
    beforeEnter: (to, from, next) => {
      if (!store.state.authUser.authenticated) {
        next({
          path: '/auth',
          name: 'auth',
          component: () => import('../views/Auth.vue')
        })
      }
      else {
        next()
      }
    }
  },
  {
    path: '/user/profile',
    name: 'userProfile',
    component: () => import(/* webpackChunkName: "about" */ '../views/UserProfile.vue'),
    beforeEnter: (to, from, next) => {
      if (!store.state.authUser.authenticated) {
        next({
          path: '/auth',
          name: 'auth',
          component: () => import('../views/Auth.vue')
        })
      }
      else {
        next()
      }
    }
  },
  {
    path: '/item/newItem',
    name: 'newItem',
    component: () => import(/* webpackChunkName: "about" */ '../views/PostItem.vue'),
    beforeEnter: (to, from, next) => {
      if (!store.state.authUser.authenticated) {
        next({
          path: '/auth',
          name: 'auth',
          component: () => import('../views/Auth.vue')
        })
      }
      else {
        next()
      }
    }
  },
  {
    path: '/item/:itemId',
    name: 'item',
    component: () => import(/* webpackChunkName: "about" */ '../views/Item.vue'),
    beforeEnter: (to, from, next) => {
      if (!store.state.authUser.authenticated) {
        next({
          path: '/auth',
          name: 'auth',
          component: () => import('../views/Auth.vue')
        })
      }
      else {
        next()
      }
    }
  },
  {
    path: '/',
    name: 'home',
    component: () => import(/* webpackChunkName: "about" */ '../views/Home.vue'),
    beforeEnter: (to, from, next) => {
      if (!store.state.authUser.authenticated) {
        next({
          path: '/auth',
          name: 'auth',
          component: () => import('../views/Auth.vue')
        })
      }
      else {
        next()
      }
    }
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
