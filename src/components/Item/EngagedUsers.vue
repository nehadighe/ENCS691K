<template>
  <div class="d-flex justify-center">
    <v-card
      :width="outerCardWidth"
      v-if="bids.length > 0"
      class="py-5 d-flex flex-column align-center scroll"
    >
      <!-- <v-card width="450" max-height="600" v-if="bids.length > 0" class="py-5 d-flex flex-column align-center scroll"> -->
      <!-- inner layer: user layer -->
      <v-card
        v-for="(item,index) in bids"
        :key="index"
        :width="innerCardwidth"
        class="px-2 py-5 my-3"
      >
        <v-row no-gutters>
          <v-col cols="3">
            <div class="px-3 d-flex justify-center">
              <v-img contain height="50" :src="item.User.avatar" />
            </div>
          </v-col>
          <v-col cols="9" class>
            <div class="px-3 d-flex flex-column">
              <div class="d-flex flex-row justify-space-between">
                <!-- <p class="mb-0">{{ item.User.username }}</p> -->
                <p class="mb-0">{{ item.User.username }}</p>
                <p class="mb-0">Bid: ${{ item.amount }}</p>
              </div>
              <p class="mb-0">{{ item.time }}</p>
            </div>
          </v-col>
        </v-row>
      </v-card>
    </v-card>
  </div>
</template>

<script>
export default {
  computed: {
    innerCardwidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return 400;
        case "sm":
          return 500;
        case "md":
          return 320;
        case "lg":
          return 400;
        case "xl":
          return 400;
        default:
          return "HelloWorld";
      }
    },
    outerCardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return 550;
        case "sm":
          return 550;
        case "md":
          return 480;
        case "lg":
          return 500;
        case "xl":
          return 500;
        default:
          return "HelloWorld";
      }
    }
  },
  props: {
    bids: Array
  },
  mounted(){
    console.log('78- ', this.bids)
  }
};
</script>

<style>
@import "../../assets/line.css";
</style>