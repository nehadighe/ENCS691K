<template>
  <v-container class="fill-height">
    <v-row class>
      <v-col cols="12">
        <div class="d-flex justify-center align-center">
          <div v-if="authMode === 'login'">
            <LoginForm 
              
            />
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
import { mapState, mapActions } from "vuex";
import LoginForm from "@/components/Auth/LoginForm.vue";
import SignUpForm from "@/components/Auth/SignUpForm.vue";

export default {
  name: "Auth",
  components: {
    LoginForm,
    SignUpForm
  },
  data: () => ({
    url: process.env.VUE_APP_URL
  }),
  computed: {
    ...mapState(["authMode"])
  },
  methods: {
    ...mapActions(["loadUserToState"])
  },
  mounted() {
    this.loadUserToState();
  }
};
</script>

<style>
@import "../assets/line.css";

.card-signing {
  padding: 30px;
}
</style>