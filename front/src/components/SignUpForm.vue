<template>
  <v-card width="800" class="card-signing elevation-2">
    <h1 class="pb-5 text-center">Sign Up</h1>
    <v-form v-model="valid">
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
            :rules="rules"
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
        </v-col>
        <!-- confirm password -->
        <v-col cols="12" md="6">
          <v-text-field
            :color="themeColor"
            :append-icon="eye ? 'mdi-eye' : 'mdi-eye-off'"
            :type="eye ? 'text' : 'password'"
            :rules="rules"
            autocomplete="new-password"
            required
            filled
            name="signin-password"
            label="Confirm Password"
            @click:append="eye = !eye"
            @keyup.enter="login"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" class="d-flex justify-center">
          <!-- <v-col cols="12" md="6" class="d-flex justify-center justify-md-end"> -->
          <v-btn
            :style="valid ? {transition: `0.3s ease`} : null"
            :color="valid ? themeColor : null"
            :class="[valid ? `white--black` : '']"
          >Sign Up</v-btn>
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
      <!-- Conditional styling -->
      <!-- <v-progress-circular
                  v-if="requestLoading"
                  :size="20"
                  :color="themeColor"
                  indeterminate
      ></v-progress-circular>-->
    </v-form>
  </v-card>
</template>

<script>
export default {
  name: "SignInForm",
  data: () => ({
    themeColor: "primary",
    eye: false,
    valid: true,
    emailRules: [
      v => !!v || "E-mail is required",
      v => /.+@.+\..+/.test(v) || "E-mail must be valid"
    ],
    rules: [v => !!v || "Input is required"],
    user: {
      username:"",
      email:"",
      firstName:"",
      lastName:"",
      password:""
    }
  })
};
</script>

<style>
.card-signing {
  padding: 30px;
}
</style>