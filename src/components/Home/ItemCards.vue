<template>
  <v-card elevation="3" class="mx-auto my-12" max-width="374" height="500" max-height="500">
    <v-carousel
      :continuous="false"
      v-if="images.length > 0"
      :cycle="cycle"
      hide-delimiter-background
      show-arrows-on-hover
      delimiter-icon="mdi-circle"
      height="250"
    >
      <v-carousel-item v-for="(item, i) in images" :key="i">
        <v-row class="fill-height" align="center" justify="center">
          <v-img height="250" :src="item.location" />
        </v-row>
      </v-carousel-item>
    </v-carousel>

    <v-img
      height="250"
      v-if="images.length <= 0"
      src="https://encs691k-assets.s3.ca-central-1.amazonaws.com/images/placeholder-img.jpeg"
    />
    <v-card-title class="d-flex align-cetner justify-space-between">
      <div>{{ title }}</div>
    </v-card-title>

    <v-card-text class>
      <div class="d-flex align-center justify-space-between">
        <div class>
          <v-chip
            class
            :color="availability == 'Active' ? 'green' : 'pink'"
            label
            text-color="white"
          >
            <v-icon small left>mdi-circle</v-icon>
            <!-- this should be dynamic mano! -->
            {{ availability }}
          </v-chip>
        </div>
        <div class>{{ currentNumberOfBidding }} bids</div>
      </div>

      <div class="my-4 subtitle-1 d-flex flex-row justify-space-between">
        <div>
          <span v-if="bidPrice === 0">$ {{ basePrice }} •</span>
          <span v-if="bidPrice != 0">$ {{ bidPrice }} •</span>
          {{ category }}
        </div>
        <div class="d-flex flex-row align-center">
          {{ userInfo.username }}
          <v-avatar class="ml-2" color="indigo" size="30">
            <v-img :src="userInfo.avatar" alt="avatar" />
          </v-avatar>
        </div>
      </div>

      <div class>{{ summary }}</div>
    </v-card-text>

    <v-card-actions class="d-flex justify-end">
      <v-btn
        text-right
        :disabled="availability != 'Active'"
        :color="darkRed"
        text
        @click="bid(id)"
      >Bid</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: "ItemCards",
  data: () => ({
    cycle: false,
    darkRed: "#900028",
    disableBidding: false
  }),
  methods: {
    bid(id) {
      this.$emit("bid", id);
    }
  },
  props: {
    id: String,
    title: String,
    images: Array,
    userInfo: Object,
    summary: String,
    availability: String,
    category: String,
    basePrice: Number, // this should be number
    bidPrice: Number,
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