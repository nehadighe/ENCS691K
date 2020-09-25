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
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import LoginForm from "@/components/LoginForm.vue";
import SignUpForm from "@/components/SignUpForm.vue";

export default {
  name: "Auth",
  components: {
    LoginForm,
    SignUpForm
  },
  data: () => ({}),
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