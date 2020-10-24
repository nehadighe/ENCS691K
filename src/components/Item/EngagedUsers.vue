<template>
  <div class="d-flex justify-center">
    <v-card width="450" max-height="600" v-if="bids.length > 0" class="py-5 d-flex flex-column align-center scroll">
        <!-- inner layer: user layer -->
        <v-card v-for="(item,index) in bids" :key="index" width="380" class="px-2 py-5 my-3">
        <v-row no-gutters>
            <v-col cols="3">
            <div class="px-3 d-flex justify-center">
                <v-img contain height="50" :src="item.image" />
            </div>
            </v-col>
            <v-col cols="9" class>
            <div class="px-3 d-flex flex-column">
                <div class="d-flex flex-row justify-space-between">
                <p class="mb-0">{{ item.username }}</p>
                <p class="mb-0">Bid: ${{ item.bid }}</p>
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
  props: {
    bids: Array,
  }
};
</script>

<style>
@import "../../assets/line.css";
</style>