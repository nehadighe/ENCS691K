<template>
  <v-card width="400" class="card-signing elevation-2">
    <h1 class="pb-5 text-center">Login</h1>
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
      <v-row>
        <v-col cols="12" class="d-flex justify-center">
          <!-- <v-col cols="12" md="6" class="d-flex justify-center justify-md-end"> -->
          <v-btn
            :style="valid ? {transition: `0.3s ease`} : null"
            :color="valid ? themeColor : null"
            :class="[valid ? `white--black` : '']"
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
</template>

<script>
export default {
  name: "LoginForm",
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
      username: "",
      password: ""
    }
  })
};
</script>

<style>
.card-signing {
  padding: 30px;
}
</style>