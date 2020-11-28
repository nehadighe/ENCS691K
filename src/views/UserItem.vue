<template>
  <v-container class="fill-height">
    <v-row class>
      <v-btn @click="changeItemStatus('Active')" class="mr-4">Available</v-btn>
      <v-btn @click="changeItemStatus('Sold')" class="ml-4">Sold</v-btn>
    </v-row>
    <v-row v-if="userItemAvailability.length > 0" class>
      <v-col
        class
        v-for="(item,index) in userItemAvailability"
        :key="index"
        cols="12"
        md="6"
        lg="4"
      >
        <UserItemCard
          :id="item.id"
          :title="item.title"
          :images="item.Images"
          :summary="item.summary"
          :availability="item.availability"
          :userInfo="item.username"
          :basePrice="item.basePrice"
          :bidPrice="item.bidPrice"
          :category="item.category"
          :ttl="item.ttl"
          :transaction="item.Transaction"
          :currentNumberOfBidding="item.currentNumberOfBidding"
          v-on:editItem="editItem($event)"
          :requestLoading="requestLoading"
          v-on:reactivateItem="reactivateItem($event)"
          v-on:deleteItem="deleteItem($event)"
        />
      </v-col>
    </v-row>
    <v-row class v-if="userItemAvailability.length <= 0">
      <v-col class="d-flex flex-column align-center justify-center">
        <v-img
          src="https://encs691k-assets.s3.ca-central-1.amazonaws.com/images/Golden_Gate_Bridge.svg"
          contain
          height="250"
        />
        <h2>No items {{ buttonState }}</h2>
      </v-col>
    </v-row>
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
  </v-container>
</template>

<script>
// @ is an alias to /src
import ItemService from "@/services/Item"; // API
import UserItemCard from "@/components/User/UserItemCard.vue";
import { mapActions, mapState } from "vuex";

export default {
  name: "UserItemVue",
  data: () => ({
    buttonState: "Active",
    disableReactivateButton: false,
    requestLoading: false,

    // message
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null
  }),
  components: {
    UserItemCard
  },
  computed: {
    ...mapState(["authUser", "userItemAvailability"])
  },
  methods: {
    ...mapActions([
      "getItemsByUsername",
      "changeUserItemAvailability",
      "deleteItemById"
    ]),
    bannerMethod(color, text) {
      this.color = color;
      this.text = text;
      this.alert = true;
    },
    changeItemStatus(buttonPressed) {
      // console.log(buttonPressed);
      if (this.buttonState != buttonPressed) {
        // don't make unnecessary computations
        // console.log("different buttons", this.buttonState);
        this.changeUserItemAvailability(buttonPressed);
      }
      this.buttonState = buttonPressed;
    },
    editItem(itemId) {
      this.$router.push({
        name: "editItem",
        params: { itemId: itemId }
      });
    },
    async deleteItem(itemId) {
      // call the API
      // console.log("line 82 - useritem view", itemId);
      this.requestLoading = true;
      await ItemService.deleteItemById(itemId)
        .then(() => {
          this.userItemAvailability.map(item => {
            if (item.id === itemId) this.deleteItemById(item);
          });
          this.bannerMethod("green", "Your item has been deleted successfully");
          this.requestLoading = false;
        })
        .catch(err => {
          console.log("line 124- useritem deleteItem controller", err);
          this.bannerMethod(
            "#900028",
            "Your item cannot be deleted at this time"
          );
          this.requestLoading = false;
        });
      // modify the store - hash code
    },
    reactivateItem(itemId) {
      console.log("line 63 - reactivateItem", itemId);
      this.userItemAvailability.map(async item => {
        if (item.id === itemId) {
          var date = new Date();
          var ttl = new Date(item.ttl); // transforming ttl in date
          date.setDate(date.getDate() - 1); // subtracting by two

          if (date > ttl) {
            await ItemService.reactivateItem(itemId)
              .then(() => {
                // need to update the state.item.itemId.ttl
                this.bannerMethod(
                  "green",
                  "Item has been reactivated in the market"
                );
              })
              .catch(() => {
                this.bannerMethod(
                  "#900028",
                  "An error ocurred while reactivating the item"
                );
              });
          } else {
            this.bannerMethod(
              "#900028",
              "Already reloaded once, wait 24 hours"
            );
          }
        }
      });
    }
  },
  async mounted() {
    // get all the information all the bids from the specific user
    await this.getItemsByUsername(this.authUser.username);
    console.log("line 172 - UserItem", this.userItemAvailability);
  }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>