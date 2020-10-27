<template>
  <v-container class="fill-height">
    <v-row class>
      <v-col class v-for="(item,index) in mockItems" :key="index" cols="12" md="6" lg="4">
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
          v-on:bid="bid($event)"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// @ is an alias to /src
import ItemCards from "@/components/Home/ItemCards.vue";
import { mapState, mapActions } from "vuex";

export default {
  name: "Home",
  data: () => ({}),
  components: {
    ItemCards
  },
  computed: {
    ...mapState(["authUser", "items", "mockItems"])
  },
  methods: {
    ...mapActions([
      "getAllItems",
    ]),
    bid(event) {
      this.$router.push({ 
        name: "item",
        params: { itemId: event }
      });
    }
  },
  async mounted() {
    // console.log('line 78, items sorted', this.itemsAvailable)

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