import Vue from 'vue';
import Amplify from 'aws-amplify'
// import Amplify from 'aws-amplify-vue'
import App from './App.vue';
import VueQuillEditor from 'vue-quill-editor'
// libraries
import vuetify from './plugins/vuetify'; // UI framework / library
import store from './store/store'; // manage data within application
import router from './router'; // interaction among pages
import aws_exports from './aws-exports'; //

Vue.use(VueQuillEditor)

Vue.config.productionTip = false
Amplify.configure(aws_exports)

new Vue({
  vuetify,
  store,
  router,
  VueQuillEditor,
  render: h => h(App)
}).$mount('#app')
