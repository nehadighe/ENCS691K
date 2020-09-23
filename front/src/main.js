import Vue from 'vue';
import App from './App.vue';
// libraries
import vuetify from './plugins/vuetify'; // UI framework / library
import store from './store/store'; // manage data within application
import router from './router'; // interaction among pages

Vue.config.productionTip = false

new Vue({
  vuetify,
  store,
  router,
  render: h => h(App)
}).$mount('#app')
