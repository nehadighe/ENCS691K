<template>
  <div>
    <div class="text-center" v-if="currentTime > 0">
      <span>{{ minutes | formatTime }}:{{ seconds | formatTime }}</span>
      <br />
    </div>
    <div class="text-center" v-if="currentTime <= 0">Time's Up!</div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import { v4 as uuidv4 } from "uuid";
import TransactionService from "@/services/Transaction"; // API

export default {
  name: "Timer",
  props: {
    deadline: [String, Date],
    speed: {
      type: Number,
      default: 1000
    },
    itemName: String,
    itemId: String,
    username: String,
    itemBidPrice: Number
    // userHasVisitedItem: Boolean
  },
  data() {
    return {
      currentTime:
        Date.parse(new Date(Date.parse(this.deadline) + 1 * 60 * 1000)) -
        Date.parse(new Date()),
      newTime: null,
      timeOut: null
    };
  },
  mounted() {
    // if this is modified, then the timer will not show
    // in there is one timer that would show back to the view
    // first timer is here to start the counter when there's a number available
    // this.countdown();
    this.timeOut = setTimeout(this.countdown, this.speed)
    // console.log('spinning of timeOut',this.timeOut);
  },
  beforeDestroy() {
    console.log('beforeMount')
    // when you stop the timer, you're stopping the current time
    // clearTimeout(this.timeOut); // so you're stopping the timer here
    clearTimeout(this.secondTimer); // so you're stopping the timer here
  },
  computed: {
    ...mapState(["detailItem", "authUser"]),
    seconds() {
      return Math.floor((this.currentTime / 1000) % 60);
    },
    minutes() {
      return Math.floor((this.currentTime / 1000 / 60) % 60);
    }
  },
  filters: {
    formatTime(value) {
      if (value < 10) {
        return "0" + value;
      }
      return value;
    }
  },
  methods: {
    ...mapActions(["changeItemAvailability"]),
    // this countdown is being executed as many times as the user
    // arrives into the item
    countdown() {
      this.currentTime =
        Date.parse(new Date(Date.parse(this.deadline) + 1 * 60 * 1000)) -
        Date.parse(new Date());
      console.log("timer going down", this.currentTime, this.$props.username, this.$props.itemName);
      if (this.currentTime > 0) {
        this.secondTimer = setTimeout(this.countdown, this.speed);
        // console.log('second timer', this.secondTimer)
      } else if (this.currentTime == 0) {
        console.log("executing transaction after timer goes off");
        this.itemSold();
        this.currentTime = null;
      }
    },
    async itemSold() {
      console.log("line 59 - itemSold");
      // this.$emit("itemSold");

      var transaction = {
        id: uuidv4(),
        itemId: this.$props.itemId, // this is the same ID as the
        username: this.$props.username,
        amount: this.$props.itemBidPrice
      };
      console.log("transaction executed", transaction);
      await TransactionService.createTransaction(transaction).then(() => {
        this.changeItemAvailability(this.detailItem.id);
      });
    }
  }
};
</script>