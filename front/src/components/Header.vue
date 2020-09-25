<template>
  <v-app-bar :color="headerColor" dark>
    <div class="d-flex align-center justify-start">
      <div>
        <v-img
          alt="Concordia Logo"
          class="shrink mr-2"
          contain
          src="https://encs691k-assets.s3.amazonaws.com/logo.png"
          transition="scale-transition"
          width="40"
        />
      </div>
      <div class="">
        <p class="red-font concordia-title text-left mb-0">Concordia</p>
        <p class="red-font class-title text-left mb-0">ENCS691K</p>
      </div>
      <!-- <v-img
        alt="Vuetify Logo"
        class="shrink mr-2"
        contain
        src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
        transition="scale-transition"
        width="40"
      />-->
      <!-- <v-img
        alt="Vuetify Logo"
        class="shrink mr-2"
        contain
        src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
        transition="scale-transition"
        width="40"
      />-->

      <!-- <v-img
        alt="Vuetify Name"
        class="shrink mt-1 hidden-sm-and-down"
        contain
        min-width="100"
        src="https://cdn.vuetifyjs.com/images/logos/vuetify-name-dark.png"
        width="100"
      />-->
    </div>

    <v-spacer></v-spacer>

    <v-btn text @click="authModeLocal('signup')">
      <span class="mr-2">Sign Up</span>
    </v-btn>
    <v-btn text @click="authModeLocal('login')">
      <span class="mr-2">Login</span>
    </v-btn>
  </v-app-bar>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "Header",
  data: () => ({
    headerColor: "#CDB394"
  }),
  methods: {
    ...mapActions(["authMode"]),
    authModeLocal(event) {
      //   console.log("verifying event", event);
      this.authMode(event);
    }
  }
};
</script>

<style>
@import "../assets/line.css";
@import "../assets/colors.css";
@import "../assets/font.css";
</style>