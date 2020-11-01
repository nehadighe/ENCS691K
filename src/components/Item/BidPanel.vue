<template>
  <div id="bid_panel" class="mt-5 d-flex justify-center">
    <v-card min-width="350" width="550" class="pa-5 d-flex flex-column">
      <div id="text-field">
        <v-form ref="form" v-model="valid">
          <v-text-field
            :color="darkRed"
            v-model="itemPrice"
            :rules="rules.required"
            type="number"
            autocomplete="itemPrice"
            prepend-inner-icon="mdi-currency-usd"
            name="item-price"
            label="Price for item"
            @keyup.enter="bid(false)"
            filled
          ></v-text-field>
        </v-form>
      </div>
      <div id="button" class="d-flex justify-end">
        <v-btn
          text-right
          class="ml-3"
          :color="darkRed"
          :disabled="!valid || disablingButton"
          text
          @click="bid(false)"
        >Bid</v-btn>
      </div>
    </v-card>
  </div>
</template>

<script>
export default {
  data: () => ({
    valid: true,
    darkRed: "#900028",
    rules: {
      required: [v => !!v || "Required."]
    },
    itemPrice: ""
  }),
  methods: {
    bid(initialBidState) {
      var event = {
        state: initialBidState,
        itemPrice: this.itemPrice
      };
      this.$emit("bid", event);
      this.$refs.form.reset();
    }
  },
  props: {
    disablingButton: Boolean
  }
};
</script>

<style>
</style>