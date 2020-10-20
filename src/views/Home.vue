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
        <div class>
          <!-- 
              Card Component:
              All props need to be passed to child component
           -->
          <ItemCards />

          <!-- Real Data -->
          <!-- <p>Image: {{ item.image }}</p>
          <p>Name: {{ item.name }}</p>
          <p>Description: {{ item.description }}</p>
          <p>Availability: {{ item.availability }}</p>
          <p>Current Bidding: {{ item.currentNumberOfBidding }}</p>-->
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// @ is an alias to /src
import ItemCards from "@/components/Home/ItemCards.vue";
import { mapState, mapActions } from "vuex";
import mockItems from "@/store/mockItems.js";
// import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: "Home",
  data: () => ({
    mockItems: mockItems
  }),
  components: {
    // HelloWorld
    ItemCards
  },
  computed: {
    ...mapState(["authUser", "items"])
  },
  methods: {
    ...mapActions(["getAllItems"])
  }
  // async mounted() {
  // get all the items data from the db as soon as logged in
  // if (this.authUser.authenticated) {
  // making sure user is authenticated
  // console.log('line 38 - home - Hello World')
  //   this.getAllItems();
  // } else {
  //   alert("Need to authenticate");
  // }
  // }
};
</script>

<style scoped>
@import "../assets/line.css";
</style>