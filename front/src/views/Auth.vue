<template>
  <v-container class="fill-height">
    <v-row>
      <!-- <v-col cols="12">
        <div class="d-flex flex-column justify-center align-center">
          <h1>Hello World</h1>
          <p>{{ authMode }}</p>
        </div>
      </v-col> -->
      <v-col cols="12">
        <div class="d-flex justify-center align-center">
          <div v-if="authMode === 'login'">
            <!-- <p>Foo</p> -->
            <LoginForm />
          </div>
          <div v-if="authMode === 'signup'">
            <!-- <p>Bar</p> -->
            <SignUpForm />
          </div>
        </div>
      </v-col>
      <!-- Banner -->
      <!-- <v-snackbar :color="bannerType" :timeout="timeout" v-model="alert">
        {{ bannerText }}
        <v-btn color="white" text @click="alert = false">
          <v-icon>mdi-window-close</v-icon>
        </v-btn>
      </v-snackbar>-->
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