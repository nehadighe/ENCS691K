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
        <v-carousel-item v-for="(item, i) in detailItem.Images" :key="i">
          <v-img contain :aspect-ratio="imageDimensions" :src="item.location" />
        </v-carousel-item>
      </v-carousel>
    </v-col>
    <v-container>
      <v-row class>
        <v-col class cols="12" md="6">
          <div class="custom-padding-item-detail">
            <div class="text-left d-flex flex-column justify-center">
              <div class="d-flex flex-row justify-space-between align-center">
                <h1 class>{{ detailItem.title }}</h1>
                <!-- timer -->
                <v-card v-if="detailItem.Bids.length > 0" style="padding:8px 15px">
                  <Timer :deadline="detailItem.startBidTime" v-on:itemSold="itemSold()" />
                </v-card>
              </div>
              <div id="item_information">
                <h3 class>${{ detailItem.bidPrice }}</h3>
                <p class>{{ detailItem.category }}</p>
                <p class>{{ detailItem.summary }}</p>
              </div>
            </div>
          </div>
          <BidPanel
            :requestLoading="requestLoading"
            :disablingButton="disableBidding"
            v-on:bid="bid($event)"
          />
        </v-col>
        <v-col cols="12" class="d-flex flex-column" md="6">
          <div class="mb-3 custom-padding-width-user-engagement">
            <h2 class="text-center text-md-left">
              <span v-if="detailItem.Bids.length < 1">No</span> User Engagement
            </h2>
          </div>
          <EngagedUsers :bids="detailItem.Bids" />
        </v-col>
      </v-row>
    </v-container>
    <!-- messaging windows -->
    <v-snackbar :color="color" :timeout="snacktimeout" v-model="alert">
      <!-- <v-snackbar :color="bannerColor" timeout="30000" :v-model="bannerAlert"> -->
      <div class="d-flex flex-row align-center justify-space-between">
        <p class="mb-0">{{ text }}</p>
        <v-btn color="white" text @click="alert = false">
          <v-icon small>mdi-window-close</v-icon>
        </v-btn>
      </div>
    </v-snackbar>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import { v4 as uuidv4 } from "uuid";
import BidService from "@/services/Bid"; // API
import TransactionService from "@/services/Transaction"; // API
import EngagedUsers from "@/components/Item/EngagedUsers.vue";
import BidPanel from "@/components/Item/BidPanel.vue";
import Timer from "@/components/Test/Timer.vue";

export default {
  data: () => ({
    cycle: false,
    disableBidding: false,
    darkRed: "#900028",
    timer: null,
    totalTime: 2 * 60, // This should be dynamic!
    startBidTime: new Date(), // date

    // Message in data
    // pop up message
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null,
    requestLoading: false
  }),
  components: {
    BidPanel,
    EngagedUsers,
    Timer
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
    bannerMethod(color, text) {
      this.color = color;
      this.text = text;
      this.alert = true;
    },
    async bid(event) {
      this.requestLoading = true;
      if (event > this.detailItem.bidPrice) {
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
          amount: event,
          time: time // this data type has to be changed to datetime
        };
        // if the bid.length is less than one
        // then the startBidTime should
        if (this.detailItem.Bids.length < 1) {
          this.startBidTime = date;
        }
        storeEvent.startBidTime = this.startBidTime;
        // API call to Bid entity/table
        await BidService.makeBid(storeEvent)
          .then(() => {
            // console.log(res);
            delete storeEvent.username;
            storeEvent.User = this.authUser;
            this.makeBid(storeEvent); // changing store
            this.bannerMethod("green", "Bid made successfully");
            this.requestLoading = false;
          })
          .catch(err => {
            console.log(err);
            this.bannerMethod("#900028", "An error occured while bidding, please try again!");
            this.requestLoading = false;
          });
        return;
      } else {
        // console.log("no it is not");
        this.bannerMethod("#900028", "Cannot bid lower than the base price");
        this.requestLoading = false;
      }
    },
    async itemSold() {
      var transaction = {
        id: uuidv4(),
        itemId: this.detailItem.id,
        username: this.authUser.username,
        amount: this.detailItem.bidPrice
      };
      await TransactionService.createTransaction(transaction).then(() => {
        this.changeItemAvailability(this.detailItem.id);
      });
      this.disableBidding = true;
    }
  },
  async mounted() {
    const itemId = this.$route.params.itemId;
    // API call to request the specific Item
    await this.showItem(itemId);
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