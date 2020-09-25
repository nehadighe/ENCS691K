<template>
  <div class>
    <v-card min-width="300" max-width="800" class="card-signing elevation-2">
      <h1 class="pb-5 text-center dark-2-golden-font">Sign Up</h1>
      <v-form ref="form" v-model="valid">
        <v-row>
          <v-col cols="12" md="6">
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
          </v-col>
          <!-- email -->
          <v-col cols="12" md="6">
            <v-text-field
              :color="themeColor"
              v-model="user.email"
              :rules="emailRules"
              autocomplete="username"
              name="signin-username"
              required
              label="Email"
              filled
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <!-- first name -->
          <v-col cols="12" md="6">
            <v-text-field
              :color="themeColor"
              v-model="user.firstName"
              :rules="rules"
              autocomplete="username"
              name="signin-username"
              required
              label="First Name"
              filled
            ></v-text-field>
          </v-col>
          <!-- last name -->
          <v-col cols="12" md="6">
            <v-text-field
              :color="themeColor"
              v-model="user.lastName"
              :rules="rules"
              autocomplete="username"
              name="signin-username"
              required
              label="Last Name"
              filled
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <!-- password -->
          <v-col cols="12" md="6">
            <v-text-field
              v-model="user.password"
              :color="themeColor"
              :append-icon="eyePass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="eyePass ? 'text' : 'password'"
              :rules="rules"
              autocomplete="new-password"
              required
              filled
              name="signin-password"
              label="Password"
              @click:append="eyePass = !eyePass"
              @keyup.enter="login"
            ></v-text-field>
          </v-col>
          <!-- confirm password -->
          <v-col cols="12" md="6">
            <v-text-field
              :color="themeColor"
              :append-icon="eyeConfirmPass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="eyeConfirmPass ? 'text' : 'password'"
              :rules="rules"
              autocomplete="new-password"
              required
              filled
              name="signin-password"
              label="Confirm Password"
              @click:append="eyeConfirmPass = !eyeConfirmPass"
              @keyup.enter="login"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" class="d-flex justify-center">
            <!-- <v-col cols="12" md="6" class="d-flex justify-center"> -->
            <v-btn
              :style="valid ? {transition: `0.3s ease`} : null"
              :color="valid ? themeColor : null"
              :class="[valid ? `white--text` : '']"
              @click="signUp()"
            >Sign Up</v-btn>
          </v-col>
          <!-- <v-col cols="12" md="6" class="d-flex justify-center">
            <v-btn @click="resetState()">Reset State</v-btn>
          </v-col>-->
        </v-row>
        <!-- Conditional styling -->
        <!-- <v-progress-circular
                  v-if="requestLoading"
                  :size="20"
                  :color="themeColor"
                  indeterminate
        ></v-progress-circular>-->
      </v-form>
    </v-card>
    <!-- Banner -->
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
import { mapActions } from "vuex";

export default {
  name: "SignInForm",
  data: () => ({
    themeColor: "#900028",
    eyePass: false,
    eyeConfirmPass: false,
    valid: true,
    emailRules: [
      v => !!v || "E-mail is required",
      v => /.+@.+\..+/.test(v) || "E-mail must be valid"
    ],
    rules: [v => !!v || "Input is required"],
    user: {
      username: "",
      email: "",
      firstName: "",
      lastName: "",
      password: ""
    },
    timeout: 30000,
    alert: false,
    text: null,
    color: null
  }),
  methods: {
    ...mapActions(["resetAppState", "userSignUp"]),
    async signUp() {
      if (!this.valid) {
        (this.text = "Input some text"),
          (this.color = "#900028"),
          (this.alert = true);
        return;
      }
      try {
        let username, password, email;
        username = this.user.username;
        password = this.user.password;
        email = this.user.email;
        // sending this data to Cognito
        const { user } = await Auth.signUp({
          username,
          password,
          attributes: {
            email // optional
            // phone_number // optional - E.164 number convention
            // other custom attributes
          }
        });
        console.log(user);
        // updating the user store
        this.userSignUp(this.user);
        this.user = {
          username: "",
          email: "",
          firstName: "",
          lastName: "",
          password: ""
        };
        this.$refs.form.reset();
        this.$router.push({ name: "home" });
      } catch (error) {
        (this.text = error.message),
          (this.color = "#900028"),
          (this.alert = true);
        console.log("error signing up:", error);
      }
    },
    resetState() {
      this.resetAppState();
    }
  }
};
</script>

<style>
@import "../assets/colors.css";
@import "../assets/line.css";

.card-signing {
  padding: 30px;
}
</style>