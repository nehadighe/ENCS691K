<template>
  <div class="mt-8">
    <v-col cols="12" class="d-flex justify-center">
      <v-carousel
        :continuous="false"
        :cycle="cycle"
        :show-arrows="false"
        hide-delimiter-background
        delimiter-icon="mdi-circle"
        height="100%"
      >
        <v-carousel-item v-for="(image, i) in detailItem.image" :key="i">
          <v-img contain :aspect-ratio="imageDimensions" :src="image" />
        </v-carousel-item>
      </v-carousel>
    </v-col>
    <v-container>
      <v-row class>
        <v-col class cols="12" md="6">
          <div class="custom-padding-item-detail">
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
              </div>
              <div id="item_information">
                <h3 class>${{ detailItem.basePrice }}</h3>
                <p class>{{ detailItem.category }}</p>
                <p class>{{ detailItem.description }}</p>
              </div>
            </div>
          </div>
          <BidPanel :disablingButton="disableBidding" v-on:bid="bid($event)" />
        </v-col>
        <v-col cols="12" class="d-flex flex-column" md="6">
          <div class="mb-3 custom-padding-width-user-engagement">
            <h2 class="text-center text-md-left">
              <span v-if="bids.length < 1">No</span> User Engagement
            </h2>
          </div>
          <EngagedUsers :bids="bids" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import BidService from "@/services/Bid"; // API
import EngagedUsers from "@/components/Item/EngagedUsers.vue";
import BidPanel from "@/components/Item/BidPanel.vue";

export default {
  data: () => ({
    localBids: [],
    cycle: false,
    disableBidding: false,
    darkRed: "#900028",
    buttonCardShow: false,
    itemId: "",
    timer: null,
    totalTime: 2 * 60 // This should be dynamic!
  }),
  components: {
    BidPanel,
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
    },
    imageDimensions() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return 1.5;
        case "sm":
          return 2.0;
        case "md":
          return 2.5;
        case "lg":
          return 3.5;
        case "xl":
          return 3.5;
        default:
          return "HelloWorld";
      }
    }
  },
  methods: {
    ...mapActions(["showItem", "makeBid", "changeItemAvailability"]),
    async bid(event) {
      if (event.initialBidState) {
        // show card
        this.buttonCardShow = true;
      } else {
        if (this.bids.length < 1) {
          this.startTimer(this.detailItem.id);
        }
        // date functions
        const date = new Date();
        const currentDate = date.toDateString();
        const hour = date.getHours();
        const minute = date.getMinutes();
        const seconds = date.getSeconds();
        const time = `${currentDate}, ${hour}:${minute}:${seconds}`;
        var storeEvent = {
          itemId: this.detailItem.id,
          username: this.authUser.username,
          userProfilePicture: this.authUser.avatar,
          amount: event.itemPrice,
          time: time // this data type has to be changed to datetime
        };
        // console.log(event)
        this.itemId = this.detailItem.id;
        // API call to Bid entity/table
        await BidService.makeBid(storeEvent)
        .then(() => {
          this.makeBid(storeEvent);
        })
        .catch(err => {
          console.log("line 134 err from API call- ", err);
        });
        
        // this.$refs.form.reset();
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
@import "../assets/responsive.css";

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