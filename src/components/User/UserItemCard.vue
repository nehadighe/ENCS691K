<template>
  <div>
    <v-card elevation="3" class="mx-auto my-12" max-width="374" height="500" max-height="500">
      <v-carousel
        v-if="images.length > 0"
        :continuous="false"
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
      <!-- in case items do not have any pictures -->
      <div>
        <v-fab-transition>
          <v-btn
            v-if="currentNumberOfBidding <= 0 && availability == 'Active'"
            :disable="disableReactivateButton"
            @click="selectItemById('reactivateItem', id)"
            class="mt-8"
            :color="darkRed"
            fab
            dark
            x-small
            absolute
            top
            left
          >
            <v-icon>mdi-reload</v-icon>
          </v-btn>
        </v-fab-transition>
        <v-img
          height="250"
          v-if="images.length <= 0"
          src="https://encs691k-assets.s3.ca-central-1.amazonaws.com/images/placeholder-img.jpeg"
        ></v-img>
      </div>
      <div style="height:50%" class>
        <div class="d-flex align-center justify-space-between">
          <v-card-title class>
            <div>{{ title }}</div>
          </v-card-title>
          <v-card-subtitle v-if="mode == 'boughtItem'" class="ma-0 mr-3 pa-0">
            Cost:
            <v-icon class="icon-size" color="green darken-2">mdi-currency-usd</v-icon>
            <span style="font-size:1.1rem">{{ transactionAmount }}</span>
          </v-card-subtitle>
          <v-card-subtitle v-if="mode == 'yourItem'" class="ma-0 mr-3 pa-0">{{ category }}</v-card-subtitle>
        </div>

        <v-card-text style="height:50%" class="mt-0 pt-2">
          <div class="d-flex align-center justify-space-between">
            <div v-if="mode == 'boughtItem'">
              <p class="mb-0">Date: {{ moment(transactionTime).format("MMMM D, YYYY") }}</p>
            </div>

            <div class>Total bids: {{ currentNumberOfBidding }}</div>

            <div v-if="transaction != null" class>
              Winning User:
              <v-icon class="icon-size" color="yellow darken-3">mdi-star</v-icon>
              {{ transaction.User.username }}
            </div>
            <div v-if="transaction == null && mode == 'yourItem'">
              <!-- :color="availability == 'Active' ? 'green' : 'orange'" -->
              <v-chip
                class="mb-3"
                :color="availability == 'Active' ? 'green' : 'orange'"
                label
                text-color="white"
              >
                <v-icon small left>mdi-circle</v-icon>
                <!-- this should be dynamic mano! -->
                {{ availability }}
              </v-chip>
            </div>
          </div>

          <div class="d-flex align-center justify-space-between">
            <div v-if="mode == 'boughtItem'">
              <p class="mb-0">Time: {{ moment(transactionTime).format("h:mm:ss a") }}</p>
            </div>
            <div v-if="mode == 'boughtItem'" class="d-flex flex-row align-center">
              {{ itemOwner.username }}
              <v-avatar class="ml-2" color="indigo" size="30">
                <v-img :src="itemOwner.avatar" alt="avatar" />
              </v-avatar>
            </div>
            <!-- <div class>Base Price: ${{ basePrice }}</div> -->
            <!-- so if transaction is done, then show this -->
            <div v-if="transaction != null">
              Highest Bid:
              <v-icon class="icon-size" color="green darken-3">mdi-currency-usd</v-icon>
              {{ transaction.amount }}
            </div>
            <div
              v-if="transaction != null"
            >Date: {{ moment(transaction.createdAt).format("MMMM D, YYYY") }}</div>
          </div>

          <div class="mt-3">{{ summary }}</div>
        </v-card-text>

        <v-card-actions v-if="currentNumberOfBidding <= 0" class="d-flex justify-end">
          <v-btn text-right :color="darkRed" text @click="selectItemById('editItem', id)">Edit</v-btn>
          <v-btn
            text-right
            :color="darkRed"
            v-if="!requestLoading"
            text
            @click="selectItemById('deleteItem', id)"
          >Delete</v-btn>
          <v-progress-circular v-if="requestLoading" :size="25" :color="darkRed" indeterminate></v-progress-circular>
        </v-card-actions>
      </div>
    </v-card>
  </div>
</template>

<script>
import moment from "moment";

export default {
  name: "UserItemCard",
  data: () => ({
    cycle: false,
    darkRed: "#900028",
    disableReactivateButton: false,
    functionType: "",
    itemId: ""
  }),
  filters: {
    moment(date) {
      return moment.utc(date).format("MMMM Do YYYY, h:mm:ss a");
    }
  },
  methods: {
    selectItemById(functionType, id) {
      this.$emit(`${functionType}`, id);
    },
    moment(date) {
      return moment.utc(date);
    }
  },
  props: {
    mode: String, // this mode will be served the anchor for dynamic rendering
    transactionTime: String,
    itemOwner: Object,
    transactionAmount: Number,
    id: String,
    title: String,
    images: Array,
    username: Object,
    summary: String,
    availability: String,
    category: String,
    basePrice: Number, // this should be number
    bidPrice: Number,
    transaction: Object,
    currentNumberOfBidding: Number,
    requestLoading: Boolean
  },
  mounted() {
    // console.log("line 148", this.$props.transactionTime);
  }
};
</script>

<style>
@import "../../assets/line.css";
.icon-size {
  font-size: 20px !important;
}
</style>