<template>
  <div class="mt-8">
    <!-- <v-container> -->
    <!-- <v-row class>
      <v-col class cols="12">
        <h1 class="text-center">Item Detail</h1>
        <h2 class="text-center">{{ detailItem.name }}</h2>
      </v-col>
    </v-row>-->
    <v-row class>
      <v-col cols="12" class="d-flex justify-center" style="height:500px">
        <v-carousel
          :continuous="false"
          :cycle="cycle"
          :show-arrows="false"
          hide-delimiter-background
          delimiter-icon="mdi-circle"
          height="450"
        >
          <v-carousel-item v-for="(image, i) in detailItem.image" :key="i">
            <!-- <v-img :src="image"/> -->
            <!-- <v-img class=""" aspect-ratio="1.9" contain :src="image" /> -->
            <!-- <v-row class="fill-height"> -->
            <!-- <v-img class="" contain widht="500" height="500" :src="image" /> -->
            <v-img contain aspect-ratio="1.65" :src="image" />
            <!-- <v-img contain height="450" :src="image" /> -->
            <!-- <v-img contain aspect-ratioheight="250" :src="image" /> -->
            <!-- </v-row> -->
          </v-carousel-item>
        </v-carousel>
      </v-col>
      <v-container>
        <v-row>
          <v-col class cols="12" md="6">
            <!-- <v-col cols="12" class="d-flex justify-center mt-8 " md="6"> -->
            <v-container>
              <div class="text-left d-flex flex-column justify-center">
                <div class="d-flex flex-row justify-space-between align-center">
                  <h1 class>{{ detailItem.name }}</h1>
                  <v-card v-if="bids.length > 0" style="padding:8px 15px">
                    <div :class="minutes < 1 ? `one-minute` : null">
                      <span id="minutes">{{ minutes }}</span>
                      <span id="middle">:</span>
                      <span id="seconds">{{ seconds }}</span>
                    </div>
                  </v-card>
                  <!-- Hello -->
                </div>
                <div id="item_information">
                  <h3 class>${{ detailItem.basePrice }}</h3>
                  <p class>{{ detailItem.category }}</p>
                  <p class>{{ detailItem.description }}</p>
                </div>
              </div>
            </v-container>
            <!-- <div id="bid_panel" class="mt-5 d-flex justify-center "> -->
            <!-- <v-card class="pa-5 d-flex flex-column"> -->
            <div id="bid_panel" class="mt-5 d-flex justify-center">
              <v-card max-width="450" width="900" class="pa-5 d-flex flex-column">
                <div id="text-field">
                  <v-form ref="form" v-model="valid">
                    <v-text-field
                      :color="darkRed"
                      v-model="itemPrice"
                      :rules="rules.required"
                      type="number"
                      autocomplete="itemPrice"
                      prepend-inner-icon="mdi-currency-usd"
                      name="item-price"
                      label="Price for item"
                      filled
                    ></v-text-field>
                  </v-form>
                </div>
                <div id="button" class="d-flex justify-end">
                  <v-btn
                    text-right
                    class="ml-3"
                    :color="darkRed"
                    :disabled="!valid || disableBidding"
                    text
                    @click="bid(false, detailItem.id)"
                  >Bid</v-btn>
                </div>
              </v-card>
            </div>
          </v-col>
          <v-col cols="12" class="d-flex flex-column" md="6">
            <!-- outer layer -->
            <div class="mb-3">
              <h2 class="text-center text-md-left">
                <span v-if="bids.length < 1">No</span> User Engagement
              </h2>
            </div>
            <EngagedUsers :bids="bids" />
          </v-col>
        </v-row>
      </v-container>
    </v-row>
    <!-- </v-container> -->
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import EngagedUsers from "@/components/Item/EngagedUsers.vue";

export default {
  data: () => ({
    localBids: [],
    valid: true,
    cycle: false,
    disableBidding: false,
    darkRed: "#900028",
    buttonCardShow: false,
    rules: {
      required: [v => !!v || "Required."]
    },
    itemPrice: "",
    itemId: "",
    timer: null,
    totalTime: 2 * 60 // This should be dynamic!
  }),
  components: {
    EngagedUsers
  },
  computed: {
    ...mapState(["detailItem", "authUser", "bids"]),
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
    ...mapActions(["showItem", "makeBid", "changeItemAvailability"]),
    bid(initialBidState, id) {
      if (initialBidState) {
        // show card
        this.buttonCardShow = true;
      } else {
        // if (this.bids.length < 1) {
        //   this.startTimer(id);
        // }
        // date functions
        const date = new Date();
        const currentDate = date.toDateString();
        const hour = date.getHours();
        const minute = date.getMinutes();
        const seconds = date.getSeconds();
        const time = `${currentDate}, ${hour}:${minute}:${seconds}`;
        var event = {
          // generate bidId
          itemId: id,
          // images:
          image: this.authUser.avatar,
          username: this.authUser.username,
          bid: this.itemPrice,
          time: time
        };
        // console.log(event)
        this.itemId = id;
        // API call to Bid entity/table
        this.makeBid(event);
        this.$refs.form.reset();
      }
    },
    startTimer() {
      // this is probably not the best implementation
      // two events might be happening at the same time
      // and one value might just be overwritten
      // but for now, let's just go with this implementation
      // this.itemId = id;
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
        // this.disableBidding = true;
        // API call to Transation entity/table
        this.itemSold(this.itemId);
        clearInterval(this.timer);
      }
    },
    padTime(time) {
      return (time < 10 ? "0" : "") + time;
    },
    itemSold() {
      this.changeItemAvailability(this.itemId);
      this.disableBidding = true;
    }
  },
  mounted() {
    const itemId = this.$route.params.itemId;
    // API call to request the specific Item
    this.showItem(itemId);
    // this localBids to handle the data locally
    // without changing the store
    this.localBids = this.bids;
  }
};
</script>

<style>
@import "../assets/line.css";

.bidding-card {
  transform: scale(1.1);
}

.one-minute {
  color: #900028;
  transition: 0.2s ease-in;
}

.scroll {
  overflow-y: auto;
}
</style>