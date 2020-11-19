<template>
  <v-container class="fill-height">
    <v-row>
      <v-col cols="12">
        <h1>User Setting View</h1>
        <h2>{{ authUser.username }}</h2>
      </v-col>
    </v-row>
    <v-row class>
      <v-col class v-for="(item,index) in authUser.Items" :key="index" cols="12" md="6" lg="4">
        <ItemCards
          :id="item.id"
          :name="item.title"
          :images="item.Images"
          :summary="item.summary"
          :availability="item.availability"
          :userInfo="item.username"
          :basePrice="item.basePrice"
          :bidPrice="item.bidPrice"
          :category="item.category"
          :currentNumberOfBidding="item.currentNumberOfBidding"
          v-on:bid="bid($event)"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// @ is an alias to /src
import ItemCards from "@/components/Home/ItemCards.vue";
import { mapActions, mapState } from "vuex";

export default {
  name: "Home",
  components: {
    ItemCards
  },
  computed: {
    ...mapState(["authUser", "items"])
  },
  methods: {
    ...mapActions(["getAllItems", "getItemsByUsername"])
  },
  async mounted() {
    // get all the information all the bids from the specific user
    await this.getItemsByUsername(this.authUser.username);
    await this.getAllItems();
    console.log("line 50- user page items", this.items);
    console.log("line 51- user page authUser.items", this.authUser.Items);
  }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>