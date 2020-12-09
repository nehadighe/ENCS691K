<template>
  <div>
    <v-card min-width="450" class="card-signing elevation-2">
      <Login
        v-if="localLoginState === 'login'"
        v-on:login="login($event)"
        v-on:forgotPassword="forgotPassword()"
        v-on:resetState="resetState()"
        :requestLoading="requestLoading"
        :themeColor="themeColor"
      />
      <ForgotPass
        v-if="localLoginState === 'forgotPass'"
        v-on:send="send($event)"
        v-on:change="change($event)"
        v-on:back="back()"
        :requestLoading="requestLoading"
        :themeColor="themeColor"
      />
    </v-card>
    <v-snackbar :color="color" :timeout="snacktimeout" v-model="alert">
      <!-- <v-snackbar :color="bannerColor" timeout="30000" :v-model="bannerAlert"> -->
      <div class="d-flex flex-row align-center justify-space-between">
        <p class="mb-0">{{ text }}</p>
        <v-btn color="white" text @click="alert = false">
          <v-icon small>mdi-window-close</v-icon>
        </v-btn>
      </div>
    </v-snackbar>
  </div>
</template>

<script>
import { Auth } from "aws-amplify";
import { mapActions } from "vuex";
import Login from "./Login";
import ForgotPass from "./ForgotPass";

export default {
  name: "LoginForm",
  components: {
    Login,
    ForgotPass
  },
  data: () => ({
    themeColor: "#900028",
    eye: false,
    valid: true,
    rules: {
      required: [v => !!v || "Required."]
    },
    requestLoading: false,
    localLoginState: "login",
    // pop up message
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null,
  }),
  methods: {
    ...mapActions(["resetAppState", "userLookUp", "setCurrentRoute", "getAllItems"]),
    forgotPassword() {
      this.localLoginState = "forgotPass";
    },
    // sending code to change password to username
    async send(event) {
      this.requestLoading = true;
      await Auth.forgotPassword(event.username)
        .then(() => {
          // once password has been reset
          // go back to login again
          (this.text = "Your code has been sent"),
            (this.color = "success"),
            (this.alert = true);
          this.requestLoading = false;
          // console.log("line 69, send method from forgot password", data);
        })
        .catch(error => {
          (this.text = error.message),
            (this.color = "#900028"),
            (this.alert = true);
          this.requestLoading = false;
        });
    },
    // changing old password to a new password
    async change(event) {
      // console.log('line 80 - change', event);
      this.requestLoading = true;
      if (event.password != event.confirmPassword) {
        (this.text = "Passwords must be same"),
          (this.color = "#900028"),
          (this.alert = true);
        this.requestLoading = false;
        return;
      }
      await Auth.forgotPasswordSubmit(
        event.user.username,
        event.code,
        event.password
      )
        .then(() => {
          event.user.authenticated = true; // adding authentication property
          this.userLogIn(event.user); // sending data to the store
          this.requestLoading = false;
          this.$router.push({ name: "home" });
          // console.log("line 95, change method from forgot password submit", data);
        })
        .catch(err => {
          (this.text = err.message),
            (this.color = "#900028"),
            (this.alert = true);
          this.requestLoading = false;
        });
    },
    // going back from forgot password component
    // to login component
    back() {
      this.localLoginState = "login";
    },
    async login(event) {
      this.requestLoading = true;
      if (!event.valid) {
        (this.text = "Input some text"),
          (this.color = "#900028"),
          (this.alert = true);
        this.requestLoading = false;
        return;
      }
      let username, password;
      username = event.user.username;
      password = event.password;
      try {
        await Auth.signIn(username, password);
        // should look at the pool of users in the store, and should
        // get that user to display in the application

        // adding authentication property: logical issue!
        // if adding it before, the header will
        // load first before even going to the
        // home
        event.user.authenticated = true;
        console.log("line 142 - login form", event.user);
        this.userLookUp(event.user); // looking up user information
        this.requestLoading = false;
        await this.getAllItems();
        this.$router.push({ name: "home" });
        this.setCurrentRoute("/");
      } catch (error) {
        (this.text = error.message),
          (this.color = "#900028"),
          (this.alert = true);
        this.requestLoading = false;
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