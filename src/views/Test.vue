<template>
  <v-container class="fill-height">
    <v-row class="d-flex justify-center align-center">
      <h1 class>Test Vue</h1>
    </v-row>
    <v-row class="d-flex justify-center align-center">
      <!-- <AutoComplete /> -->
      <!-- the deadline needs be better -->
      <Timer deadline="10/23/2020"/>
    </v-row>
  </v-container>
</template>

<script>
// import AutoComplete from "@/components/Test/AutoComplete.vue";
import Timer from "@/components/Test/Timer.vue";
// import LoginForm from "@/components/Auth/LoginForm.vue";
export default {
  name: "Test",
  components: {
    Timer
    // AutoComplete,
  }
};
</script>

<style>
@import "../assets/line.css";
</style>