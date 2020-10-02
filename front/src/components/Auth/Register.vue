<template>
  <div>
    <h1 class="pb-5 text-center dark-2-golden-font">Sign Up</h1>
    <v-form ref="form" v-model="valid">
      <v-row>
        <v-col cols="12" md="6">
          <v-text-field
            :color="themeColor"
            v-model="user.username"
            :rules="rules.required"
            autocomplete="username"
            name="signin-username"
            label="Username"
            filled
          ></v-text-field>
        </v-col>
        <!-- email -->
        <v-col cols="12" md="6">
          <v-text-field
            :color="themeColor"
            v-model="user.email"
            :rules="rules.email"
            autocomplete="username"
            name="signin-username"
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
            :rules="rules.required"
            autocomplete="username"
            name="signin-username"
            label="First Name"
            filled
          ></v-text-field>
        </v-col>
        <!-- last name -->
        <v-col cols="12" md="6">
          <v-text-field
            :color="themeColor"
            v-model="user.lastName"
            :rules="rules.required"
            autocomplete="username"
            name="signin-username"
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
            :rules="rules.password"
            autocomplete="new-password"
            filled
            name="signin-password"
            label="Password"
            @click:append="eyePass = !eyePass"
          ></v-text-field>
        </v-col>
        <!-- confirm password -->
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
            @keyup.enter="signUp()"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" class="d-flex justify-center">
          <!-- <v-col cols="12" md="6" class="d-flex justify-center"> -->
          <v-btn
            v-if="!requestLoading"
            :style="valid ? {transition: `0.3s ease`} : { cursor: `auto !important` }"
            :color="valid ? themeColor : null"
            :class="[valid ? `white--text` : '']"
            @click="valid ? signUp(): null"
            :ripple="false"
          >Sign Up</v-btn>
          <v-progress-circular v-if="requestLoading" :size="25" :color="themeColor" indeterminate></v-progress-circular>
        </v-col>
      </v-row>
    </v-form>
  </div>
</template>

<script>
export default {
  name: "Register",
  data: () => ({
    valid: true,
    eyePass: false,
    eyeConfirmPass: false,
    rules: {
      email: [
        v => !!v || "Required.",
        v => /.+@.+\..+/.test(v) || "E-mail must be valid."
      ],
      required: [v => !!v || "Required."],
      password: [
        v => !!v || "Required.",
        v => (v && v.length >= 8) || "minimum 8 characters"
      ]
    },
    user: {
      username: "",
      email: "",
      firstName: "",
      lastName: "",
      password: "",
      confirmPassword: ""
    },
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
    signUp() {
      var event = {
        // constructing the event to pass to parent
        valid: this.valid,
        user: {
          username: this.user.username,
          email: this.user.email,
          firstName: this.user.firstName,
          lastName: this.user.lastName
        },
        password: this.user.password,
        confirmPassword: this.user.confirmPassword
      };
      this.$emit("signUp", event);
      this.$refs.form.reset();
    }
  }
};
</script>

<style>
</style>