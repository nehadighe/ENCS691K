<template>
  <v-container class="fill-height">
    <v-row class="d-flex justify-center align-center">
      <h1 class>Test Vue</h1>
    </v-row>
    <v-row class="d-flex justify-center align-center">
      <Timer deadline="November 17 2020 23:59:59 GMT+0200"/>
      <!-- <Timer/> -->
    </v-row>
  </v-container>
</template>

<script>
import Timer from "@/components/Test/Timer.vue";
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