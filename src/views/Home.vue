<template>
  <v-container class="fill-height">
    <v-row v-if="items.length > 0" class>
      <v-col class v-for="(item,index) in items" :key="index" cols="12" md="6" lg="4">
        <!-- 
              Card Component:
              All props need to be passed to child component
        -->
        <ItemCards
          :id="item.id"
          :title="item.title"
          :images="item.Images"
          :summary="item.summary"
          :availability="item.availability"
          :userInfo="item.User"
          :basePrice="item.basePrice"
          :bidPrice="item.bidPrice"
          :category="item.category"
          :currentNumberOfBidding="item.currentNumberOfBidding"
          v-on:bid="bid($event)"
        />
      </v-col>
    </v-row>
    <v-row v-if="items.length < 1">
      <v-col class="d-flex flex-column align-center justify-center" cols="12">
        <v-img
          src="https://encs691k-assets.s3.ca-central-1.amazonaws.com/images/Berlin_TV_Tower.svg"
          contain
          height="250"
          class="mb-3"
        />
        <h2 class="mt-5">There are no items in the market at the moment</h2>
        <v-btn class="mt-4" @click="newItemVue()" color="secondary">Start selling</v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// @ is an alias to /src
import ItemServices from "@/services/Item";
import ItemCards from "@/components/Home/ItemCards.vue";
import { v4 as uuidv4 } from "uuid";
import { mapState, mapActions } from "vuex";

export default {
  name: "Home",
  data: () => ({}),
  components: {
    ItemCards
  },
  computed: {
    ...mapState(["authUser", "items", "mockItems", "currentRoute", "visited", "items"])
  },
  methods: {
    ...mapActions([
      "getAllItems",
      "getItemById",
      "setCurrentRoute",
      "pushItemIdToVisitedArr",
      "changeUserHasVisitedItem"
    ]),
    async newItemVue() {
      // would have to implement the ItemService here
      // to create a new record
      var item = {
        Images: [],
        id: uuidv4(),
        title: "",
        category: "",
        description: "",
        summary: "",
        availability: "Pending",
        currentNumberOfBidding: "",
        basePrice: "",
        bidPrice: "",
        startBidTime: "",
        ttl: "", // ttl should be enabled
        username: this.authUser.username
      };
      await ItemServices.post(item)
        .then(() => {
          // I am not posting the item inside of the Items state array
          if (this.currentRoute === "editItem") console.log("same route");
          else {
            this.$router.push({
              name: "editItem",
              params: { itemId: item.id }
            });
          }
          this.setCurrentRoute("editItem");
        })
        .catch(err => {
          this.bannerMethod("#900028", err);
        });
    },
    async bid(event) {
      // if (!this.visited.includes(event)) console.log('hello world')
      // if (!this.visited.includes(event)) this.pushItemIdToVisitedArr(event)
      // else console.log('this is inside of the visited array')
      if (!this.visited.includes(event)) {
        this.changeUserHasVisitedItem(false);
        // this.userHasVisitedItem = false;
        console.log(
          "line 227- does visited include item.id",
          this.visited.includes(event)
        );
        this.pushItemIdToVisitedArr(event); // add it if it's not included
      } else {
        this.changeUserHasVisitedItem(true);
        console.log(
          "line 230- does visited include item.id",
          this.visited.includes(event)
        );
      }
      await this.getItemById(event);
      this.$router.push({
        name: "item",
        params: { itemId: event }
      });
      this.setCurrentRoute(`/item/${event}`);
    }
  },
  async mounted(){
    await this.getAllItems();
  }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>