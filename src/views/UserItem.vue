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
    buttonState: 'Active',
    disableReactivateButton: false
  }),
  components: {
    UserItemCard
  },
  computed: {
    ...mapState(["authUser", "userItemAvailability"])
  },
  methods: {
    ...mapActions(["getItemsByUsername", "changeUserItemAvailability"]),
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
      console.log("line 62 - editItem", itemId);
    },
    deleteItem(itemId) {
      console.log("line 65 - deleteItem", itemId);
    },
    async reactivateItem(itemId) {
      console.log("line 63 - reactivateItem", itemId);
      // check if item has been reactivated before
      //
      await ItemService.reactivateItem(itemId)
        .then(result => {
          console.log("line 66- reactivateItem success", result);
          // need to update the state.item.itemId.ttl
        })
        .catch(err => {
          console.log("line 68- reactivateItem error", err);
        });
    }
  },
  async mounted() {
    // get all the information all the bids from the specific user
    await this.getItemsByUsername(this.authUser.username);
    console.log('line 100 - UserItem', this.userItemAvailability)
  }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>