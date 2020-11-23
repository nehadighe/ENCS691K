<template>
  <div>
    <v-card elevation="3" class="mx-auto my-12" max-width="374" height="500" max-height="500">
      <v-carousel
        :continuous="false"
        :cycle="cycle"
        hide-delimiter-background
        show-arrows-on-hover
        delimiter-icon="mdi-circle"
        height="250"
      >
        <v-carousel-item v-for="(item, i) in images" :key="i">
          <v-row class="fill-height" align="center" justify="center">
            <v-img height="250" :src="item.location">
              <v-fab-transition>
                <v-btn
                  v-if="currentNumberOfBidding <= 0"
                  :disable="disableReactivateButton"
                  @click="selectItemById('reactivateItem', id)"
                  class="mt-8 ml-3"
                  :color="darkRed"
                  fab
                  dark
                  x-small
                  absolute
                  top
                  left
                >
                  <v-icon>mdi-reload</v-icon>
                </v-btn>
              </v-fab-transition>
            </v-img>
          </v-row>
        </v-carousel-item>
      </v-carousel>
      <div style="height:50%" class>
        <div class="d-flex align-center justify-space-between">
          <v-card-title class>
            <div>{{ title }}</div>
          </v-card-title>
          <v-card-subtitle class="ma-0 mr-3 pa-0">{{ category }}</v-card-subtitle>
        </div>

        <v-card-text style="height:50%" class="mt-0 pt-2">
          <div class="d-flex align-center justify-space-between">
            <div class>Total bids: {{ currentNumberOfBidding }}</div>
            <div v-if="transaction != null" class>
              Winning User:
              <v-icon class="icon-size" color="yellow darken-3">mdi-star</v-icon>
              {{ transaction.User.username }}
            </div>
          </div>
          <div class="d-flex align-center justify-space-between">
            <div class>Base Price: ${{ basePrice }}</div>
            <div v-if="transaction != null">
              Highest Bid:
              <v-icon class="icon-size" color="green darken-3">mdi-currency-usd</v-icon>
              {{ transaction.amount }}
            </div>
          </div>

          <div class="mt-3">{{ summary }}</div>
        </v-card-text>

        <v-card-actions v-if="currentNumberOfBidding <= 0" class="d-flex justify-end">
          <v-btn
            text-right
            :color="darkRed"
            disabled
            text
          >Edit</v-btn>
          <v-btn
            text-right
            :color="darkRed"
            v-if="!requestLoading"
            text
            @click="selectItemById('deleteItem', id)"
          >Delete</v-btn>
          <v-progress-circular v-if="requestLoading" :size="25" :color="darkRed" indeterminate></v-progress-circular>
        </v-card-actions>
      </div>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "UserItemCard",
  data: () => ({
    cycle: false,
    darkRed: "#900028",
    disableReactivateButton: false,
    functionType: '',
    itemId: ''
  }),
  methods: {
    selectItemById(functionType, id) {
      this.$emit(`${functionType}`, id);
    },
  },
  props: {
    id: String,
    title: String,
    images: Array,
    username: Object,
    summary: String,
    availability: String,
    category: String,
    basePrice: Number, // this should be number
    bidPrice: Number,
    transaction: Object,
    currentNumberOfBidding: Number,
    requestLoading: Boolean
  },
};
</script>

<style>
@import "../../assets/line.css";
.icon-size {
  font-size: 20px !important;
}
</style>