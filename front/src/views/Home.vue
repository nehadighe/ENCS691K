<template>
  <v-container class="fill-height">
    <!-- <img alt="Vue logo" src="../assets/logo.png"> -->
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <v-row>
      <v-col cols="12">
        <h1>Welcome Home, {{ user.username }}!</h1>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// @ is an alias to /src
import { mapState } from "vuex";
// import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: "Home",
  components: {
    // HelloWorld
  },
  computed: {
    ...mapState(["user"])
  }
  // mounted() {
  //   console.log('Hello World')
  // }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>