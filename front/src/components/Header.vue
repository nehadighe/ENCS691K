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
      <div class>
        <p class="red-font concordia-title text-left mb-0">Concordia</p>
        <p class="red-font class-title text-left mb-0">ENCS691K</p>
      </div>
    </div>

    <v-spacer></v-spacer>

    <!-- Unauthenticated users -->
    <div v-if="!user.authenticated">
      <v-btn text @click="authModeLocal('signup')">
        <span class="mr-2">Sign Up</span>
      </v-btn>
      <v-btn text @click="authModeLocal('login')">
        <span class="mr-2">Login</span>
      </v-btn>
    </div>
    <!-- User Login -->
    <div v-if="user.authenticated">
      <v-btn text @click="authModeLocal('login')">
        <span class="mr-2">{{ user.username }}</span>
      </v-btn>
      <v-btn text @click="logOut()">
        <span class="mr-2">Logout</span>
      </v-btn>
    </div>
  </v-app-bar>
</template>

<script>
import { Auth } from "aws-amplify";
import { mapActions, mapState } from "vuex";

export default {
  name: "Header",
  data: () => ({
    headerColor: "#CDB394",
    authenticate: null
  }),
  computed: {
    ...mapState(["user"])
  },
  methods: {
    ...mapActions(["resetAppState", "authMode"]),
    authModeLocal(event) {
      //   console.log("verifying event", event);
      this.authMode(event);
    },
    async logOut() {
      try {
        await Auth.signOut({ global: true });
        this.resetAppState();
        this.$router.push({ name: "auth" });
      } catch (error) {
        console.log("error signing out: ", error);
      }
    }
  },
  mounted() {
    // this.authenticate = user;
    console.log(this.user);
  }
};
</script>

<style>
@import "../assets/line.css";
@import "../assets/colors.css";
@import "../assets/font.css";
</style>