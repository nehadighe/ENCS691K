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
                  <!-- <Timer :deadline="moment(this.detailItem.startBidTime).format()" /> -->
                  <Timer
                    :deadline="moment(this.detailItem.startBidTime).format()"
                    :itemName="this.detailItem.title"
                    :itemId="this.detailItem.id"
                  />
                  <!-- <Timer
                    :deadline="moment(this.detailItem.startBidTime).format()"
                    :userHasVisitedItem="this.userHasVisitedItem"
                    :itemName="this.detailItem.title"
                    :itemId="this.detailItem.id"
                  /> -->
                  <!-- <Timer
                    :deadline="moment(this.detailItem.startBidTime).format()"
                    :itemName="this.detailItem.title"
                    :username="this.authUser.username"
                    :itemId="this.detailItem.id"
                    :itemBidPrice="this.detailItem.bidPrice"
                  />-->
                  <!-- <p class="mb-0">timer</p> -->
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
import BidService from "@/services/Bid"; // API
import EngagedUsers from "@/components/Item/EngagedUsers.vue";
import BidPanel from "@/components/Item/BidPanel.vue";
import Timer from "@/components/Test/Timer.vue";
import moment from "moment";

export default {
  data: () => ({
    cycle: false,
    disableBidding: false,
    darkRed: "#900028",
    timer: null,
    startBidTime: new Date(), // date
    userHasVisitedItem: null,

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
    ...mapState(["detailItem", "authUser", "bids", "visited"]),
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
    ...mapActions([
      "showItem",
      "makeBid",
      "changeItemAvailability",
      "getItemById",
      "pushItemIdToVisitedArr"
    ]),
    bannerMethod(color, text) {
      this.color = color;
      this.text = text;
      this.alert = true;
    },
    bid(event) {
      this.requestLoading = true;
      if (event > this.detailItem.bidPrice) {
        // date functions
        if (this.authUser.username === this.detailItem.User.username) {
          console.log("You cannot bid on your own item");
          this.bannerMethod("#900028", "You cannot bid on your own item");
          this.requestLoading = false;
        }
        // else console.log('youre not the same person');
        else this.bidFunction(event);
      } else {
        // console.log("no it is not");
        this.bannerMethod("#900028", "Cannot bid lower than the base price");
        this.requestLoading = false;
      }
    },
    async bidFunction(event) {
      const date = new Date();
      const currentDate = date.toDateString();
      const hour = date.getHours();
      const minute = date.getMinutes();
      const seconds = date.getSeconds();
      const time = `${currentDate}, ${hour}:${minute}:${seconds}`;
      var storeEvent = {
        itemId: this.detailItem.id,
        username: this.authUser.username, //
        amount: event, //
        time: time // this data type has to be changed to datetime
      };

      // capturing the first bit by comparing
      // whether the length is less than 1
      console.log(
        "line 165- before the this.detailItem.Bids.length < 1",
        this.detailItem.Bids.length
      );
      if (
        this.detailItem.Bids.length < 1 &&
        this.detailItem.startBidTime == null
      ) {
        console.log("line 167 - inside of hte Bids.length logic");
        this.startBidTime = moment(date)
          .utc()
          .format();
        storeEvent.startBidTime = this.startBidTime;
      } else storeEvent.startBidTime = this.detailItem.startBidTime;
      console.log(
        "line 173 - this should not be changing-->",
        this.detailItem.startBidTime
      );
      console.log("line 174-", storeEvent);
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
          this.bannerMethod(
            "#900028",
            "An error occured while bidding, please try again!"
          );
          this.requestLoading = false;
        });
      this.requestLoading = false;
      // console.log('line 187',this.startBidTime)
    },
    moment(date) {
      return moment.utc(date);
    }
  },
  mounted() {
    console.log(
      "line 198 -- mounted() item",
      this.authUser.username,
      "startBidTime",
      this.detailItem.startBidTime
    );
    // if (!this.visited.includes(this.detailItem.id)) {
    //   this.userHasVisitedItem=false
    //   console.log('line 227- does visited include item.id',this.visited.includes(this.detailItem.id))
    //   this.pushItemIdToVisitedArr(this.detailItem.id) // add it if it's not included
    // } else {
    //   this.userHasVisitedItem=true
    //   console.log('line 230- does visited include item.id',this.visited.includes(this.detailItem.id))
    // }
    // somewhere around here it should be recorded that the user
    // has arrived in the item once
    // item.map
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