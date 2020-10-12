<template>
  <div class>
    <v-card min-width="300" max-width="800" class="card-signing elevation-2">
      <!-- data is going to have to be sent down to the children -->
      <Register
        v-if="localSignUpState === 'register'"
        v-on:signUp="signUp($event)"
        v-on:resetState="resetState()"
        :requestLoading="requestLoading"
        :themeColor="themeColor"
      />
      <Verification
        v-if="localSignUpState === 'verification'"
        v-on:verifyCode="verifyCode($event)"
        v-on:resentVerification="resentVerification()"
        :themeColor="themeColor"
      />
    </v-card>
    <!-- Banner -->
    <v-snackbar :color="color" :timeout="snacktimeout" v-model="alert">
      <div class="d-flex flex-row align-center justify-space-between">
        <p class="mb-0 white--text">{{ text }}</p>
        <v-btn color="white" text @click="alert = false">
          <v-icon small>mdi-window-close</v-icon>
        </v-btn>
      </div>
    </v-snackbar>
  </div>
</template>

<script>
import { Auth } from "aws-amplify";
import UserService from "@/services/User";
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
    themeColor: "#900028",
    username: "",
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null,
    requestLoading: false,
    localSignUpState: "register"
  }),
  methods: {
    ...mapActions(["resetAppState", "userSignUp"]),
    async signUp(event) {
      this.requestLoading = true;
      if (!event.valid) {
        (this.text = "Input some text"),
          (this.color = "#900028"),
          (this.alert = true);
        this.requestLoading = false;
        return;
      } else if (event.user.password != event.confirmPassword) {
        (this.text = "Passwords must be same"),
          (this.color = "#900028"),
          (this.alert = true);
        this.requestLoading = false;
        return;
      }
      try {
        this.username = event.user.username;
        let username, password, email;
        username = event.user.username;
        password = event.user.password;
        email = event.user.email;
        // sending this data to Cognito
        await Auth.signUp({
          username,
          password,
          attributes: {
            email // optional
          }
        });
        // Making API call in the try clause
        await UserService.post(event.user).then(() => {
          event.user.authenticated = true // adding authentication property
          this.userSignUp(event.user); // sending data to the store
        }).catch(err => {
          console.log('line 91 err from API call- ',err)
        });
        (this.text = "Your account has been created successfully!"),
          (this.color = "success"),
          (this.alert = true);
        // changing local signUp state for account verification
        this.localSignUpState = "verification";
        this.requestLoading = false;
      } catch (error) {
        (this.text = error.message),
          (this.color = "#900028"),
          (this.alert = true);
        this.requestLoading = false;
      }
    },
    async verifyCode(event) {
      this.requestLoading = true;
      try {
        await Auth.confirmSignUp(this.username, event.code);
        this.requestLoading = false;
        this.$router.push({ name: "home" });
      } catch (error) {
        (this.text = error.message),
          (this.color = "#900028"),
          (this.alert = true);
        this.requestLoading = false;
      }
    },
    async resentVerification() {
      // this avoid overloading the resend of events without the HTTP error
      try {
        await Auth.resendSignUp(this.username);
        (this.text = "Code resent successfully"),
          (this.color = "success"),
          (this.alert = true);
      } catch (err) {
        (this.text = err.message),
          (this.color = "#900028"),
          (this.alert = true);
        console.log("error resending code: ", err);
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

.extraTextStyle {
  transition: 0.3s ease;
  color: #b08c62 !important;
}

.extraTextStyle:hover {
  transition: 0.3s ease;
  color: #ad712a !important;
}
</style>