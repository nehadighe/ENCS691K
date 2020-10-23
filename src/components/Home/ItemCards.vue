<template>
  <v-card elevation="3" class="mx-auto my-12" max-width="374">
    <v-carousel
      :continuous="false"
      :cycle="cycle"
      hide-delimiter-background
      show-arrows-on-hover
      delimiter-icon="mdi-circle"
      height="250"
    >
      <v-carousel-item v-for="(image, i) in images" :key="i">
        <v-row class="fill-height" align="center" justify="center">
          <!-- <v-img :src="image"/> -->
          <!-- <v-img class="test-1" aspect-ratio="1.9" contain :src="image" /> -->
          <v-img height="250" :src="image" />
        </v-row>
      </v-carousel-item>
    </v-carousel>

    <v-card-title class="d-flex align-cetner justify-space-between">
      <div>{{ name }}</div>

      <!-- <div class="one-minute"> -->
      <!-- <div v-if="currentNumberOfBidding > 1" :class="minutes < 1 ? `one-minute` : null"> -->
      <div :class="minutes < 1 ? `one-minute` : null">
        <!-- <div :colors="minutes < 1 ? 'pink' : null"> -->
        <span id="minutes">{{ minutes }}</span>
        <span id="middle">:</span>
        <span id="seconds">{{ seconds }}</span>
      </div>
    </v-card-title>

    <v-card-text class>
      <div class="d-flex align-center justify-space-between">
        <div class>
          <v-chip class :color="availability == 'Active' ? 'green' : 'pink'" label text-color="white">
            <v-icon small left>mdi-circle</v-icon>
            <!-- this should be dynamic mano! -->
            {{ availability }}
          </v-chip>
        </div>
        <div class>{{ currentNumberOfBidding }} bids</div>
      </div>

      <div class="my-4 subtitle-1">$ {{ basePrice }} • {{ category }}</div>

      <div class>{{ description }}</div>
    </v-card-text>
    <v-card-actions class="d-flex justify-end">
      <v-btn text-right :color="darkRed" text @click="startTimer(id)">Bid</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: "ItemCards",
  data: () => ({
    cycle: false,
    darkRed: "#900028",
    itemId: "",
    timer: null,
    totalTime: 2 * 60, // This should be dynamic!
  }),
  computed: {
    minutes() {
      const minutes = Math.floor(this.totalTime / 60);
      return this.padTime(minutes);
    },
    seconds() {
      const seconds = this.totalTime - this.minutes * 60;
      return this.padTime(seconds);
    }
  },
  methods: {
    // should this be here?
    // passing components to children (this component)
    // from props
    startTimer(event) {
      // this.$emit("startTimer");
      console.log('line 82- Item', event)
      // this is probably not the best implementation
      // two events might be happening at the same time
      // and one value might just be overwritten
      // but for now, let's just go with this implementation
      this.itemId = event;
      this.timer = setInterval(() => this.countdown(), 1000);
    },
    countdown() {
      if (this.totalTime >= 1) {
        this.totalTime--;
      } else {
        this.totalTime = 0;
        // there should be another function here where it
        // disables the bidding button, or at least
        // should present a modal that the auction has been
        // closed
        this.itemSold();
        clearInterval(this.timer);
      }
    },
    padTime(time) {
      return (time < 10 ? "0" : "") + time;
    },
    itemSold() {
      this.$emit("itemSold", this.itemId);
    }
  },
  props: {
    id: String,
    name: String,
    images: Array,
    description: String,
    availability: String,
    category: String,
    basePrice: Number,
    currentNumberOfBidding: Number
  }
};
</script>

<style>
@import "../../assets/line.css";
.one-minute {
  color: #900028;
  transition: 0.2s ease-in;
}
</style>