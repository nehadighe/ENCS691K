<template>
  <v-container class="fill-height">
    <v-row class="d-flex justify-center align-center">
      <h1 class>Test Vue</h1>
    </v-row>
    <v-row class="d-flex justify-center align-center">
      <AutoComplete />
    </v-row>
  </v-container>
</template>

<script>
import AutoComplete from "@/components/Test/AutoComplete.vue";
// import LoginForm from "@/components/Auth/LoginForm.vue";
export default {
  name: "Test",
  components: {
    AutoComplete
  }
};
</script>

<style>
@import "../assets/line.css";
</style>