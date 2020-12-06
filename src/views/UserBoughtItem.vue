<template>
  <v-container>
    <v-row class>
      <v-col cols="12">
        <h1>Items Bought</h1>
      </v-col>
    </v-row>
    <v-row v-if="userItemBought.length > 0" class>
      <v-col class v-for="(item,index) in userItemBought" :key="index" cols="12" md="6" lg="4">
        <UserItemCard
          :id="item.Item.id"
          :title="item.Item.title"
          :images="item.Item.Images"
          :summary="item.Item.summary"
          :availability="item.Item.availability"
          :userInfo="item.Item.username"
          :basePrice="item.Item.basePrice"
          :bidPrice="item.Item.bidPrice"
          :category="item.Item.category"
          :ttl="item.Item.ttl"
          :transaction="item.Item.Transaction"
          :mode="'boughtItem'"
          :transactionAmount="item.amount"
          :transactionTime="item.createdAt"
          :itemOwner="item.Item.User"
          :currentNumberOfBidding="item.Item.currentNumberOfBidding"
          v-on:editItem="editItem($event)"
          v-on:reactivateItem="reactivateItem($event)"
          v-on:deleteItem="deleteItem($event)"
        />
      </v-col>
    </v-row>
    <v-row class v-if="userItemBought.length <= 0">
      <v-col class="d-flex flex-column align-center justify-center">
        <v-img
          src="https://encs691k-assets.s3.ca-central-1.amazonaws.com/images/Golden_Gate_Bridge.svg"
          contain
          height="250"
        />
        <h2>No items Bought</h2>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import UserItemCard from "@/components/User/UserItemCard.vue";
import { mapActions, mapState } from "vuex";

export default {
  name: "UserBoughtItem",
  components: {
    UserItemCard
  },
  computed: {
    ...mapState(["authUser", "userItemBought"])
  },
  methods: {
    ...mapActions(["getTransactionByUsername"])
  },
  async mounted() {
    await this.getTransactionByUsername(this.authUser.username);
    // console.log("line 52 - user bought items", this.userItemBought);
  }
};
</script>

<style>
</style>