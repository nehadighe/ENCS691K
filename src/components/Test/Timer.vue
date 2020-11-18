<template>
  <div>
    <div class="text-center" v-if="currentTime">
      <span>{{ minutes | formatTime }}:{{ seconds | formatTime }}</span>
      <br />
    </div>
    <div class="text-center" v-if="!currentTime">Time's Up!</div>
  </div>
</template>

<script>
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
      currentTime: Date.parse(new Date(Date.parse(this.deadline) + 5 * 60 * 1000)) - Date.parse(new Date()),
      newTime: null
    };
  },
  mounted() {
    setTimeout(this.countdown, this.speed);
  },
  computed: {
    seconds() {
      return Math.floor((this.currentTime / 1000) % 60);
    },
    minutes() {
      return Math.floor((this.currentTime / 1000 / 60) % 60);
    },
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
      this.currentTime = Date.parse(new Date(Date.parse(this.deadline) + 5 * 60 * 1000)) - Date.parse(new Date());
      if (this.currentTime > 0) {
        setTimeout(this.countdown, this.speed);
      } else {
        this.itemSold();
        this.currentTime = null;
      }
    },
    itemSold() {
      this.$emit("itemSold");
    }
  }
};
</script>