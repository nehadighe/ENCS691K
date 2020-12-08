<template>
  <div>
    hello {{ currentTime }}
    <div class="text-center" v-if="currentTime > 0">
      <span>{{ minutes | formatTime }}:{{ seconds | formatTime }}</span>
      <br />
    </div>
    <div class="text-center" v-if="currentTime <= 0">Time's Up!</div>
  </div>
</template>

<script>
import moment from "moment";

export default {
  name: "Timer",
  props: {
    deadline: [String, Date],
    speed: {
      type: Number,
      default: 1000
    }
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
    countdown() {
      // adding five minutes to deadline and subtracting to current time
      this.currentTime =
        Date.parse(new Date(Date.parse(this.$props.deadline) + 1 * 60 * 1000)) -
        Date.parse(new Date());
      // there is an issue with the timer
      // it errors out
      // but also need to visualize the deadline as a
      console.log(
        "line 54 - 5 minute interval",
        moment(
          // issue is laying here
          // there is a sudden drop in time calculation
          new Date(Date.parse(this.$props.deadline) + 1 * 60 * 1000)
        ).format("MMMM D, YYYY, h:mm:ss a")
      );
      console.log(
        "line 55 - current time moment",
        moment(new Date()).format("MMMM D, YYYY, h:mm:ss a")
      );
      console.log("line 56 - is this.currenTime > 0", this.currentTime > 0);
      if (this.currentTime > 0) {
        console.log("line 51 - yes it is, time should count down");
        setTimeout(this.countdown, this.speed);
      } else if (this.currentTime == 0) {
        // this.itemSold();
        console.log("line 54 - no, it should execute the sale now");
        this.currentTime = null;
      } else {
        console.log("time is negative");
      }
    },
    itemSold() {
      this.$emit("itemSold");
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

    // giving me exact date
    // console.log('getting into timer: this.currentTime', moment(new Date()).format("MMMM D, YYYY, h:mm:ss a"), 'this.deadline', moment(new Date(Date.parse(this.$props.deadline) + 2 * 60 * 1000)).format("MMMM D, YYYY, h:mm:ss a"))
    // console.log('getting into timer: this.currentTime', new Date()), 'this.deadline', moment(new Date(Date.parse(this.$props.deadline) + 2 * 60 * 1000)).format("MMMM D, YYYY, h:mm:ss a"))

    // gave me a weird date in 1969
    // console.log('getting into timer: this.currentTime', moment(this.currentTime).format("MMMM D, YYYY, h:mm:ss a"), 'this.deadline', moment(new Date(Date.parse(this.$props.deadline) + 2 * 60 * 1000)).format("MMMM D, YYYY, h:mm:ss a"))
    // console.log('getting into timer: this.currentTime', moment(this.currentTime).format("MMMM D, YYYY, h:mm:ss a"), 'this.deadline', this.$props.deadline)
    setTimeout(this.countdown, this.speed);
  }
};
</script>