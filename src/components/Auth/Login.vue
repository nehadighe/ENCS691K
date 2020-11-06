<template>
  <div>
    <h1 class="pb-5 text-center dark-2-golden-font">Login</h1>
    <v-form ref="form" v-model="valid">
      <v-text-field
        :color="themeColor"
        v-model="user.username"
        :rules="rules.required"
        autocomplete="username"
        name="signin-username"
        label="Username"
        filled
      ></v-text-field>
      <v-text-field
        v-model="user.password"
        :color="themeColor"
        :append-icon="eye ? 'mdi-eye' : 'mdi-eye-off'"
        :type="eye ? 'text' : 'password'"
        :rules="rules.required"
        autocomplete="new-password"
        filled
        name="signin-password"
        label="Password"
        @click:append="eye = !eye"
        @keyup.enter="[valid ? login() : null]"
      ></v-text-field>
      <div class="d-flex align-left">
        <a class="mb-2 text-left extraTextStyle" @click="forgotPassword()">Forgot Password?</a>
      </div>
      <v-row>
        <!-- <v-col cols="12" md="6" class="d-flex justify-center"> -->
        <v-col cols="12" class="d-flex justify-center">
          <v-btn
            v-if="!requestLoading"
            :style="valid ? {transition: `0.3s ease`} : { cursor: `auto !important` }"
            :color="valid ? themeColor : null"
            :class="[valid ? `white--text` : '']"
            :ripple="false"
            @click="[valid ? login() : null]"
          >Login</v-btn>
          <v-progress-circular v-if="requestLoading" :size="25" :color="themeColor" indeterminate></v-progress-circular>
        </v-col>
        <!-- <v-col cols="12" md="6" class="d-flex justify-center">
          <v-btn :ripple="false" @click="resetState()">Reset State</v-btn>
        </v-col>-->
      </v-row>
    </v-form>
  </div>
</template>

<script>
export default {
  name: "Login",
  data: () => ({
    eye: false,
    valid: true,
    rules: {
      email: [
        v => !!v || "Required.",
        v => /.+@.+\..+/.test(v) || "E-mail must be valid."
      ],
      required: [v => !!v || "Required."]
    },
    user: {
      username: "",
      password: ""
    },
    timeout: 30000,
    alert: false,
    text: null,
    color: null
  }),
  props: {
    themeColor: String,
    requestLoading: Boolean
  },
  methods: {
    forgotPassword() {
      this.$emit("forgotPassword");
    },
    login() {
      var event = {
        // constructing the event to pass to parent
        valid: this.valid,
        user: {
          username: this.user.username
        },
        password: this.user.password
      };
      this.$emit("login", event);
      this.$refs.form.reset();
    },
    resetState() {
      this.$emit("resetState");
    }
  }
};
</script>

<style>
</style>