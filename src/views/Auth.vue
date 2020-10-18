<template>
  <v-container class=" fill-height">
    <v-row class="">
      <v-col cols="12">
        <div class="d-flex justify-center align-center">
          <div v-if="authMode === 'login'">
            <LoginForm />
          </div>
          <div v-if="authMode === 'signup'">
            <SignUpForm />
          </div>
        </div>
        <p> Hello World {{ url }}</p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import LoginForm from "@/components/Auth/LoginForm.vue";
import SignUpForm from "@/components/Auth/SignUpForm.vue";

export default {
  name: "Auth",
  components: {
    LoginForm,
    SignUpForm
  },
  data: () => ({
    url: process.env.VUE_APP_URL,
  }),
  computed: {
    ...mapState(["authMode"])
  }
};
</script>

<style>
@import "../assets/line.css";

.card-signing {
  padding: 30px;
}
</style>