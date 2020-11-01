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
          <v-img height="250" :src="image" />
        </v-row>
      </v-carousel-item>
    </v-carousel>

    <v-card-title class="d-flex align-cetner justify-space-between">
      <div>{{ title }}</div>
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
      <v-btn text-right :disabled="disableBidding" :color="darkRed" text @click="bid(id)">Bid</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: "ItemCards",
  data: () => ({
    cycle: false,
    darkRed: "#900028",
    disableBidding: false,
  }),
  methods: {
    bid (id) {
      this.$emit("bid", id);
    },
  },
  props: {
    id: String,
    title: String,
    images: Array,
    description: String,
    availability: String,
    category: String,
    basePrice: String, // this should be number
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