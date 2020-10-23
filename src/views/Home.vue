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
          <ItemCards
            :id="item.id"
            :name="item.name"
            :images="item.image"
            :description="item.description"
            :availability="item.availability"
            :basePrice="item.basePrice"
            :category="item.category"
            :currentNumberOfBidding="item.currentNumberOfBidding"

            :minutes="minutes"
            :seconds="seconds"
            :activeItem="activeItem"
            v-on:startTimer="startTimer($event)"
          />
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
    mockItems: mockItems,
    // timer variables
    identifiedId: '',
    timer: null,
    totalTime: 2 * 60,
    activeItem: true // active item is not dynamic
  }),
  components: {
    // HelloWorld
    ItemCards
  },
  computed: {
    // ...mapState(["authUser", "items", "mockItems"]),
    ...mapState(["authUser", "items"]),
    // minutes and seconds are hollistic
    // they are not specific for one item
    // they are not dynamic
    minutes() {
      const minutes = Math.floor(this.totalTime / 60);
      this.mockItems.map((item) => {
        // console.log('line 68-', item.id)
        if (item.id == this.identifiedId) {
          // change the store every minute?
          console.log(item.timer.minutes)
          // item.timer.minutes = minutes
          // return this.padTime(item.timer.minutes);
          // console.log('line 70- hello world')
        }
      })
      // console.log('line 71- minutes',minutes)
      return this.padTime(minutes);
    },
    seconds() {
      const seconds = this.totalTime - this.minutes * 60;
      return this.padTime(seconds);
    }
  },
  methods: {
    ...mapActions(["getAllItems"]),
    startTimer(event) {
      // send the Id to identify which minute/seconds to start
      console.log('line 84- home page: ',event)
      this.identifiedId = event
      this.timer = setInterval(() => this.countdown(), 1000);
    },
    countdown() {
      if (this.totalTime >= 1) {
        this.totalTime--;
      } else {
        this.totalTime = 0;
        this.activeItem = false;
        // clearing the interval of time so that it doesn't
        // keep calling the countdown function.
        // there should be another function here where it
        // disables the bidding button, or at least
        // should present a modal that the auction has been
        // closed

        // API call to the Item Service saying that the item
        // state should be changed to not avalilable

        // await TransactionService.post(event.user)
        //   .then(() => {})
        //   .catch(err => {
        //     console.log("line 91 err from API call- ", err);
        //   });
        clearInterval(this.timer);
      }
    },
    padTime(time) {
      return (time < 10 ? "0" : "") + time;
    }
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