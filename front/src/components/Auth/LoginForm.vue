<template>
  <div>
    <v-card min-width="450" class="card-signing elevation-2">
      <Login
        v-if="localLoginState === 'login'"
        v-on:login="login($event)"
        v-on:forgotPassword="forgotPassword()"
        :themeColor="themeColor"
      />
      <ForgotPass
        v-if="localLoginState === 'forgotPass'"
        v-on:send="send($event)"
        v-on:change="change($event)"
        v-on:back="back()"
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
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null,
    localLoginState: "login"
  }),
  methods: {
    ...mapActions(["resetAppState", "userLogIn"]),
    forgotPassword() {
      this.localLoginState = "forgotPass";
    },
    // sending code to change password to username
    async send(event) {
      await Auth.forgotPassword(event.username)
        .then(data => {
          // once password has been reset
          // go back to login again
          (this.text = "Your code has been sent"),
            (this.color = "success"),
            (this.alert = true);
          console.log("send method from forgot password", data);
        })
        .catch(error => {
          (this.text = error.message),
            (this.color = "#900028"),
            (this.alert = true);
          console.log(error);
        });
    },
    // changing old password to a new password
    async change(event) {
      console.log('line 80 - change', event);
      if (event.password != event.confirmPassword) {
        (this.text = "Passwords must be same"),
          (this.color = "#900028"),
          (this.alert = true);
        return;
      }
      await Auth.forgotPasswordSubmit(
        event.user.username,
        event.code,
        event.password
      )
        .then(data => {
          this.userLogIn(event.user); // sending data to the store
          this.$router.push({ name: "home" });
          console.log("change method from forgot password submit", data);
        })
        .catch(err => {
          (this.text = err.message),
            (this.color = "#900028"),
            (this.alert = true);
          console.log(err);
        });
    },
    // going back from forgot password component
    // to login component
    back() {
      this.localLoginState = "login";
    },
    async login(event) {
      if (!event.valid) {
        (this.text = "Input some text"),
          (this.color = "#900028"),
          (this.alert = true);
      }
      let username, password;
      username = event.user.username;
      password = event.password;
      await Auth.signIn(username, password)
        .then(() => {
          this.userLogIn(event.user); // sending data to the store
          this.$router.push({ name: "home" });
        })
        .catch(error => {
          (this.text = error.message),
            (this.color = "#900028"),
            (this.alert = true);
          console.log(error);
        });
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