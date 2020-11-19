<template>
  <v-container class="fill-height">
    <v-row class>
      <v-col class v-for="(item,index) in items" :key="index" cols="12" md="6" lg="4">
        <!-- 
              Card Component:
              All props need to be passed to child component
        -->
        <ItemCards
          :id="item.id"
          :name="item.title"
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
    if (this.authUser.authenticated) {
      // making sure user is authenticated
      await this.getAllItems();
      console.log('line 55- home page', this.items)
    } else {
      alert("Need to authenticate");
    }
  }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>