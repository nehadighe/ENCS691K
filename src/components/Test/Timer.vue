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
// import moment from "moment";
import { mapState, mapActions } from "vuex";
import { v4 as uuidv4 } from "uuid";
import TransactionService from "@/services/Transaction"; // API
import moment from "moment";

export default {
  name: "Timer",
  props: {
    deadline: [String, Date],
    speed: {
      type: Number,
      default: 1000
    },
    // rollback would be to remove all these variables
    itemName: String,
    itemId: String,
    // userHasVisitedItem: Boolean
    // username: String,
    // itemBidPrice: Number
  },
  data() {
    return {
      currentTime:
        Date.parse(new Date(Date.parse(this.$props.deadline) + 1 * 60 * 1000)) -
        Date.parse(new Date()),
      newTime: null
    };
  },
  computed: {
    ...mapState(["detailItem", "authUser", "userHasVisitedItem"]),
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
    countdown() {
      // adding five minutes to deadline and subtracting to current time
      this.currentTime =
        Date.parse(new Date(Date.parse(this.$props.deadline) + 1 * 60 * 1000)) -
        Date.parse(new Date());
      console.log(
        this.$props.itemName,
        "timer is going down for item:",
        this.itemId,
        this.currentTime
        // "for this amount:",
        // this.$props.itemBidPrice
      );
      if (this.currentTime > 0) {
        setTimeout(this.countdown, this.speed);
      } else if (this.currentTime == 0) {
        console.log(
          "execute transaction for item:",
          this.$props.itemName,
          this.$props.itemId
        );
        // this would also be considered as rollback
        // this.itemSold(); // this line would execute the transaction
        this.currentTime = 0;
      }
    },
    async itemSold() {
      // emit an event saying that the timer has stopped for the item
      var transaction = {
        id: uuidv4(),
        itemId: this.$props.itemId, // this is the same ID as the
        username: this.$props.username,
        amount: this.$props.itemBidPrice
      };

      await TransactionService.createTransaction(transaction).then(() => {
        this.changeItemAvailability(this.detailItem.id);
      });
    }
  },
  mounted() {
    console.log(
      "getting into timer: this.deadline human",
      moment(new Date(Date.parse(this.$props.deadline) + 2 * 60 * 1000)).format(
        "MMMM D, YYYY, h:mm:ss a"
      ),
      "this.deadline date.parse",
      Date.parse(new Date(Date.parse(this.$props.deadline) + 2 * 60 * 1000))
    );
    console.log(
      "getting into timer: this.currentTime human",
      moment(new Date()).format("MMMM D, YYYY, h:mm:ss a"),
      "this.currentTime date.parse",
      Date.parse(new Date())
    );
    // if the user has NOT visited the item, set the timer
    console.log('line 116 -', this.userHasVisitedItem)
    if (!this.userHasVisitedItem) {
      console.log('line 118- mounted() setTimeout')
      setTimeout(this.countdown, this.speed);
    } else {
      console.log('line 121- mounted() DONT setTimeout')
    }
  }
};
</script>