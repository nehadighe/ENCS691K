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
            </div>
          </div>
          <div class="d-flex align-center justify-space-between">
            <div class>Base Price: ${{ basePrice }}</div>
            <div v-if="transaction != null">
              Highest Bid:
              <v-icon class="icon-size" color="green darken-3">mdi-currency-usd</v-icon>
            </div>
          </div>

          <div class="mt-3">{{ summary }}</div>
        </v-card-text>

        <v-card-actions class="d-flex justify-end">
          <v-btn
            text-right
            :disabled="availability != 'Active'"
            :color="darkRed"
            text
            @click="selectItemById('editItem', id)"
          >Edit</v-btn>
          <v-btn
            text-right
            :disabled="availability != 'Active'"
            :color="darkRed"
            text
            @click="selectItemById('deleteItem', id)"
          >Delete</v-btn>
        </v-card-actions>
      </div>
    </v-card>
    <!-- messaging windows -->
    <v-snackbar :color="color" :timeout="snacktimeout" v-model="alert">
      <!-- <v-snackbar :color="bannerColor" timeout="30000" :v-model="bannerAlert"> -->
      <div class="d-flex flex-row align-center justify-space-between">
        <p class="mb-0">{{ text }}</p>
        <v-btn color="white" text @click="alert = false">
          <v-icon small>mdi-window-close</v-icon>
        </v-btn>
      </div>
    </v-snackbar>
  </div>
</template>

<script>
export default {
  name: "UserItemCard",
  data: () => ({
    cycle: false,
    darkRed: "#900028",
    disableReactivateButton: false,
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null
  }),
  methods: {
    selectItemById(functionType, id) {
      // console.log("line 80- UserItemCard", functionType, id);
      var date = new Date();
      var ttl = new Date(this.$props.ttl);
      date.setDate(date.getDate() - 1); // subtracting by two
      // console.log("line 86- ", ttl);
      // console.log("line 87- UserItemCard", date.toDateString());
      if (date > ttl) {
        this.$emit(`${functionType}`, id);
        (this.text = "Item has been reactivated in the market"),
          (this.color = "green"),
          (this.alert = true);
      } else {
        (this.text = "Already reloaded once, wait 24 hours"),
          (this.color = "#900028"),
          (this.alert = true);
      }
    }
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
    transaction: Array,
    ttl: String, // coming back as String from the Database
    currentNumberOfBidding: Number
  },
  mounted() {
    console.log('line 140- have to test transaction functionality', this.$props.transaction)
  }
};
</script>

<style>
@import "../../assets/line.css";
.one-minute {
  color: #900028;
  transition: 0.2s ease-in;
}

.icon-size {
  font-size: 20px !important;
}
</style>