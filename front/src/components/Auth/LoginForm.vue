<template>
  <div>
    <v-card min-width="450" class="card-signing elevation-2">
      <h1 class="pb-5 text-center dark-2-golden-font">Login</h1>
      <v-form v-model="valid">
        <v-text-field
          :color="themeColor"
          v-model="user.username"
          :rules="rules"
          autocomplete="username"
          name="signin-username"
          required
          label="Username"
          filled
        ></v-text-field>
        <v-text-field
          v-model="user.password"
          :color="themeColor"
          :append-icon="eye ? 'mdi-eye' : 'mdi-eye-off'"
          :type="eye ? 'text' : 'password'"
          :rules="rules"
          autocomplete="new-password"
          required
          filled
          name="signin-password"
          label="Password"
          @click:append="eye = !eye"
          @keyup.enter="login"
        ></v-text-field>
        <div class="d-flex align-left">
          <a class="mb text-left" @click="helloWorld()">Forgot Password?</a>
        </div>
        <v-row>
          <v-col cols="12" class="d-flex justify-center">
            <v-btn
              :style="valid ? {transition: `0.3s ease`} : null"
              :color="valid ? themeColor : null"
              :class="[valid ? `white--text` : '']"
            >Login</v-btn>
          </v-col>
          <!-- <v-col cols="12" md="6" class="d-flex justify-center justify-md-start">
                  <v-btn
                    v-if="!requestLoading"
                    :style="valid ? {transition: `0.3s ease`} : null"
                    :color="valid ? themeColor : null"
                    :class="[valid ? `white--black` : '']"
                    @click="login"
                  >Login</v-btn>
          </v-col>-->
        </v-row>
      </v-form>
    </v-card>
    <v-snackbar :color="color" v-model="alert">
      <!-- <v-snackbar :color="bannerColor" timeout="30000" :v-model="bannerAlert"> -->
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

export default {
  name: "LoginForm",
  data: () => ({
    themeColor: "#900028",
    eye: false,
    valid: true,
    emailRules: [
      v => !!v || "E-mail is required",
      v => /.+@.+\..+/.test(v) || "E-mail must be valid"
    ],
    rules: [v => !!v || "Input is required"],
    user: {
      username: "",
      password: ""
    },
    timeout: 30000,
    alert: false,
    text: null,
    color: null
  }),
  methods: {
    async login() {
      if (!this.valid) {
        (this.text = "Input some text"),
          (this.color = "#900028"),
          (this.alert = true);
      }
      let username, password;
      username = this.user.username;
      password = this.user.password;
      await Auth.signIn(username, password)
        .then(() => {
          this.user = {
            username: "",
            password: ""
          };
          this.$refs.form.reset();
          this.$router.push({ name: "home" });
        })
        .catch(error => {
          (this.text = error.message),
            (this.color = "#900028"),
            (this.alert = true);
          console.log(error);
        });
    },
    helloWorld() {
      console.log("Venezula!");
    }
  }
};
</script>

<style>
@import "../../assets/colors.css";

.card-signing {
  padding: 30px;
}
</style>