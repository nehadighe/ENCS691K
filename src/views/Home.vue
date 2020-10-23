<template>
  <v-container class="fill-height">
    <!-- <img alt="Vue logo" src="../assets/logo.png"> -->
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <v-row class>
      <v-col class cols="12">
        <h1 class="text-center">Welcome Home, {{ authUser.username }}!</h1>
      </v-col>
    </v-row>
    <v-row class>
      <!-- defining the items -->
      <v-col class v-for="(item,index) in mockItems" :key="index" cols="12" sm="6" md="4">
        <!-- 
              Card Component:
              All props need to be passed to child component
        -->
        <ItemCards
          :id="item.id"
          :name="item.name"
          :images="item.image"
          :description="item.description"
          :availability="item.availability"
          :basePrice="item.basePrice"
          :category="item.category"
          :currentNumberOfBidding="item.currentNumberOfBidding"
          v-on:itemSold="itemSold($event)"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// @ is an alias to /src
import ItemCards from "@/components/Home/ItemCards.vue";
import { mapState, mapActions } from "vuex";
import _ from "lodash";
// import mockItems from "@/store/mockItems.js";
// import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: "Home",
  data: () => ({
    // itemsAvailable: []
    // mockItems: mockItems
  }),
  components: {
    // HelloWorld
    ItemCards
  },
  computed: {
    ...mapState(["authUser", "items", "mockItems"])
    // ...mapState(["authUser", "items"])
  },
  methods: {
    ...mapActions(["getAllItems", "changeItemAvailability"]),
    itemSold(event) {
      console.log("line 58, item has been sold", event); // event = itemId
      // this is supposed to change the availability property in the store
      // this can potentially be named as itemSold
      this.changeItemAvailability(event);

      // API call to the Item Service saying that the item
      // state should be changed to not avalilable
      // await TransactionService.post()
      //   .then(() => {})
      //   .catch(err => {
      //     console.log("line 91 err from API call- ", err);
      //   });
    }
  },
  async mounted() {
    // order mockItems by availability
    const sortedItems = _.orderBy(this.mockItems, function (o) {
      return o.availability
    }, ['asc']);
    this.itemsAvailable = sortedItems
    console.log('line 78, items sorted', this.itemsAvailable)

    // get all the items data from the db as soon as logged in
    // if (this.authUser.authenticated) {
    //   // making sure user is authenticated
    //   this.getAllItems();
    // } else {
    //   alert("Need to authenticate");
    // }
  }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>