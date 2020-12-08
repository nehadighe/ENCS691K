<template>
  <v-container class="fill-height">
    <v-row class="d-flex justify-center align-center">
      <h1 class>Test Vue</h1>
    </v-row>
    <v-row class="d-flex justify-center align-center flex-column">
      <!-- <Timer deadline="November 17 2020 23:59:59 GMT+0200"/> -->
      <!-- <Timer/> -->
      <v-btn @click="getDate()">Date</v-btn>
      <p class="mt-5">time right now: {{ timeRightNow }}</p>
      <p class="mt-5">addingTime: {{ addingTime }}</p>
      <p class="mt-5">currentTime: {{ currentTimeN }}</p>
      <p class="mt-5">currentTime parse: {{ currentTimeP }}</p>
    </v-row>
  </v-container>
</template>

<script>
// import Timer from "@/components/Test/Timer.vue";
export default {
  name: "Test",
  components: {
    // Timer
    // AutoComplete,
  },
  data() {
    return {
      timeRightNow: null,
      addingTime: new Date(
        Date.parse("2020-12-07T15:56:11.00Z")
      ),
      currentTimeP:
        Date.parse(
          new Date(Date.parse("2020-12-07T16:08:11") + 2 * 60 * 1000)
        ) - Date.parse(new Date()),
      currentTimeN:
        new Date(Date.parse("2020-12-07T16:08:11") + 2 * 60 * 1000) -
        Date.parse(new Date())
    };
  },
  methods: {
    getDate() {
      this.timeRightNow = new Date()
    }
  }
};
</script>

<style>
@import "../assets/line.css";
</style>