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
          <v-col class="2" cols="12" md="6">
            <!-- <v-col cols="12" class="d-flex justify-center mt-8 " md="6"> -->
            <div class="text-left">
              <h1 class>{{ detailItem.name }}</h1>
              <h3 class>${{ detailItem.basePrice }}</h3>
              <p class>{{ detailItem.category }}</p>
              <p class>{{ detailItem.description }}</p>
            </div>
            <div class="d-flex justify-center">
              <v-btn text-right v-if="!buttonCardShow" :color="darkRed" text @click="bid(true)">Bid</v-btn>
            </div>
            <div id="bid_panel" v-if="buttonCardShow" class="mt-5">
              <v-card class="pa-5 d-flex flex-column">
                <div id="text-field">
                  <v-text-field
                    :color="darkRed"
                    v-model="itemPrice"
                    :rules="rules.required"
                    autocomplete="itemPrice"
                    name="item-price"
                    label="Price for item"
                    filled
                  ></v-text-field>
                </div>
                <div id="button" class="d-flex justify-end">
                  <v-btn
                    text-right
                    class="mr-3"
                    :disabled="disableBidding"
                    :color="darkRed"
                    text
                    @click="bid"
                  >Back</v-btn>
                  <v-btn text-right class="ml-3" :color="darkRed" text @click="bid(false)">Bid</v-btn>
                </div>
              </v-card>
            </div>
          </v-col>
          <v-col cols="12" class="d-flex justify-center" md="6">
            <!-- outer layer -->
            <v-card width="450" v-if="bids.length > 0" class="py-5 d-flex flex-column align-center">
              <!-- inner layer: user layer -->
              <v-card v-for="(item,index) in bids" :key="index" width="380" class="px-2 py-5 my-3">
                <v-row no-gutters>
                  <v-col cols="3">
                    <div class="px-3 d-flex justify-center">
                      <v-img contain height="50" :src="item.image" />
                    </div>
                  </v-col>
                  <v-col cols="9" class="">
                    <div class="px-3 d-flex flex-column">
                      <div class="d-flex flex-row justify-space-between">
                        <p class="mb-0">{{ item.username }}</p>
                        <p class="mb-0">Bid: {{ item.bid }}</p>
                      </div>
                      <p class="mb-0">{{ item.time }}</p>
                    </div>
                  </v-col>
                </v-row>
              </v-card>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-row>
    <!-- </v-container> -->
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

// should be passing the id from the screen
export default {
  data: () => ({
    cycle: false,
    darkRed: "#900028",
    buttonCardShow: false,
    rules: {
      required: [v => !!v || "Required."]
    },
    itemPrice: ""
  }),
  computed: {
    ...mapState(["detailItem", "authUser", "bids"])
  },
  methods: {
    ...mapActions(["showItem", "makeBid"]),
    bid(initialBidState) {
      if (initialBidState) {
        // show card
        this.buttonCardShow = true;
      } else {
        console.log("name, image, time and bidding amont");
        var event = {
          avatar: this.authUser.avatar,
          username: this.authUser.username,
          biddingAmount: this.itemPrice
          // time: need to figure this out,
        };
        this.makeBid(event);
      }
    }
  },
  mounted() {
    const itemId = this.$route.params.itemId;
    // API call to request the specific Item
    this.showItem(itemId);
  }
};
</script>

<style>
@import "../assets/line.css";

.bidding-card {
  transform: scale(1.1);
}
</style>