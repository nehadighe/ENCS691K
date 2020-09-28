<template>
  <div class>
    <v-card min-width="300" max-width="800" class="card-signing elevation-2">
      <!-- data is going to have to be sent down to the children -->
      <Register
        v-if="localSignUpState === 'register'"
        v-on:signUp="signUp($event)"
        :themeColor="themeColor"
      />
      <Verification
        v-if="localSignUpState === 'verification'"
        v-on:verifyCode="verifyCode($event)"
        :themeColor="themeColor"
      />
    </v-card>
    <!-- Banner -->
    <v-snackbar :color="color" v-model="alert">
      <div class="d-flex flex-row align-center justify-space-between">
        <p class="mb-0">{{ text }}</p>
        <v-btn color="white" text @click="banner.alert = false">
          <v-icon small>mdi-window-close</v-icon>
        </v-btn>
      </div>
    </v-snackbar>
  </div>
</template>

<script>
import { Auth } from "aws-amplify";
import { mapActions } from "vuex";
import Register from "./Register";
import Verification from "./Verification";

export default {
  name: "SignInForm",
  components: {
    Register,
    Verification
  },
  data: () => ({
    // parameters to be sent as props to child
    themeColor: "#900028",
    username: "",
    // Locally handled within class
    timeout: 30000,
    alert: false,
    text: null,
    color: null,
    localSignUpState: "register"
  }),
  methods: {
    ...mapActions(["resetAppState", "userSignUp"]),
    // DUMMY FUNCTIONS
    // async signUp(event) {
    //   console.log("Hello World from Sign Up", event); // so this event is undefined
    //   this.localSignUpState = "verification";
    // },
    // async verifyCode(event) {
    //   console.log("Hello World from verify code", event);
    // },

    // ACTUAL FUNCTIONS
    async signUp(event) {
      if (!event.valid) {
        (this.text = "Input some text"),
          (this.color = "#900028"),
          (this.alert = true);
        return;
      }
      try {
        this.username = event.user.username;
        let username, password, email;
        username = event.user.username;
        password = event.user.password;
        email = event.user.email;
        // sending this data to Cognito
        const { user } = await Auth.signUp({
          username,
          password,
          attributes: {
            email // optional
          }
        });
        console.log(user);
        // updating the user store
        this.userSignUp(event.user);
        // changing local signUp state for account verification
        this.localSignUpState = "verification";
      } catch (error) {
        (this.text = error.message),
          (this.color = "#900028"),
          (this.alert = true);
        console.log("error signing up", error.message);
      }
    },
    async verifyCode(event) {
      try {
        await Auth.confirmSignUp(this.username, event.code);
        this.$router.push({ name: "home" });
      } catch (error) {
        (this.text = error.message),
          (this.color = "#900028"),
          (this.alert = true);
        console.log("error confirming sign up", error.message);
      }
    },
    resetState() {
      this.resetAppState();
    }
  }
};
</script>

<style>
@import "../../assets/colors.css";
@import "../../assets/line.css";

.card-signing {
  padding: 30px;
}
</style>