<template>
  <div>
    <h1 class="pb-5 text-center dark-2-golden-font">Forgot Password</h1>
    <div v-if="localForgotPassState === 'forgotPassword'" id="getForgotPassCode">
      <v-form ref="formForgotPass" v-model="validForgotPass">
        <v-text-field
          :color="themeColor"
          v-model="user.username"
          :rules="rules.required"
          autocomplete="username"
          name="username"
          label="Username"
          filled
          @keyup.enter="[valid ? signUp() : null]"
        ></v-text-field>
        <v-row>
          <v-col v-if="requestLoading" cols="12" class="d-flex justify-center">
            <v-progress-circular :size="25" :color="themeColor" indeterminate></v-progress-circular>
          </v-col>
          <v-col v-if="!requestLoading" cols="12" md="6" class="d-flex justify-center justify-md-end">
            <v-btn
              v-if="!requestLoading"
              :style="validForgotPass ? {transition: `0.3s ease`} : { cursor: `auto !important` }"
              :color="validForgotPass ? themeColor : null"
              :class="[validForgotPass ? `white--text` : '']"
              :ripple="false"
              @click="[validForgotPass ? send() : null]"
            >Send</v-btn>
          </v-col>
          <v-col cols="12" md="6" class="d-flex justify-center justify-md-start">
            <v-btn v-if="!requestLoading" :ripple="false" @click="back">Back</v-btn>
          </v-col>
        </v-row>
      </v-form>
    </div>
    <div v-if="localForgotPassState === 'changePassword'" id="changePassword">
      <v-form ref="formChangePass" v-model="validChangePass">
        <v-row>
          <v-col cols="12" md="6">
            <v-text-field
              :color="themeColor"
              v-model="user.username"
              :rules="rules.required"
              autocomplete="username"
              name="username"
              label="Username"
              filled
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="6">
            <v-text-field
              :color="themeColor"
              v-model="code"
              :rules="rules.required"
              name="code"
              label="Code"
              filled
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" md="6">
            <v-text-field
              v-model="user.password"
              :color="themeColor"
              :append-icon="eyePass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="eyePass ? 'text' : 'password'"
              :rules="rules.password"
              autocomplete="new-password"
              filled
              name="new-password"
              label="New Password"
              @click:append="eyePass = !eyePass"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="6">
            <v-text-field
              v-model="user.confirmPassword"
              :color="themeColor"
              :append-icon="eyeConfirmPass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="eyeConfirmPass ? 'text' : 'password'"
              :rules="[passwordConfirmationRule]"
              autocomplete="confirm-password"
              filled
              name="confirm-signin-password"
              label="Confirm Password"
              @click:append="eyeConfirmPass = !eyeConfirmPass"
              @keyup.enter="[validChangePass ? change() : null]"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" class="d-flex justify-center">
            <v-btn
              v-if="!requestLoading"
              :style="validChangePass ? {transition: `0.3s ease`} : { cursor: `auto !important` }"
              :color="validChangePass ? themeColor : null"
              :class="[validChangePass ? `white--text` : '']"
              :ripple="false"
              @click="[validChangePass ? change() : null]"
            >Change Password</v-btn>
            <v-progress-circular v-if="requestLoading" :size="25" :color="themeColor" indeterminate></v-progress-circular>
          </v-col>
        </v-row>
      </v-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "ForgotPass",
  data: () => ({
    eyePass: false,
    eyeConfirmPass: false,
    validForgotPass: true,
    validChangePass: true,
    rules: {
      required: [v => !!v || "Required."],
      password: [
        v => !!v || "Required.",
        v => (v && v.length >= 8) || "minimum 8 characters"
      ]
    },
    code: "",
    user: {
      username: "",
      password: "",
      confirmPassword: ""
    },
    timeout: 30000,
    alert: false,
    text: null,
    color: null,
    localForgotPassState: "forgotPassword"
  }),
  computed: {
    passwordConfirmationRule() {
      return () =>
        this.user.password === this.user.confirmPassword ||
        "Password must match";
    }
  },
  props: {
    themeColor: String,
    requestLoading: Boolean
  },
  methods: {
    // sending code to change password to username
    send() {
      var event = {
        // constructing the event to pass to parent
        validForgotPass: this.validForgotPass,
        username: this.user.username
      };
      this.$emit("send", event);
      this.localForgotPassState = "changePassword";
      //   this.$refs.formForgotPass.reset(); // would this be needed
    },
    change() {
      var event = {
        validChangePass: this.validChangePass,
        code: this.code,
        user: {
          username: this.user.username
        },
        password: this.user.password,
        confirmPassword: this.user.confirmPassword
      };
      this.$emit("change", event);
      this.$refs.formChangePass.reset(); // would this be needed
    },
    // going back to login screen
    back() {
      this.$emit("back");
    }
  }
};
</script>

<style>
</style>