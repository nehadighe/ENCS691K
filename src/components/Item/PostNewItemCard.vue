<template>
  <v-card class="pa-5">
    <div class>
      <v-form ref="form" v-model="valid">
        <v-text-field
          :color="darkRed"
          v-model="itemName"
          :rules="rules.required"
          autocomplete="itemName"
          name="item-price"
          label="Name"
          filled
        ></v-text-field>
        <v-text-field
          :color="darkRed"
          v-model="itemSummary"
          :rules="rules.required"
          autocomplete="itemSummary"
          name="item-summary"
          label="Summary"
          filled
        ></v-text-field>
        <v-text-field
          :color="darkRed"
          v-model="itemDescription"
          autocomplete="itemDescription"
          label="Description"
          filled
        ></v-text-field>
        <v-text-field
          :color="darkRed"
          v-model="itemCategory"
          autocomplete="itemCategory"
          label="Category"
          filled
        ></v-text-field>
        <v-text-field
          :color="darkRed"
          v-model="itemPrice"
          type="number"
          :rules="rules.required"
          autocomplete="itemName"
          prepend-inner-icon="mdi-currency-usd"
          name="item-price"
          label="Price"
          filled
        ></v-text-field>
      </v-form>
    </div>
    <div class="d-flex justify-end align-end">
      <v-btn
        v-if="!requestLoading"
        class="ml-3"
        :color="darkRed"
        :disabled="!valid"
        text
        @click="create()"
      >Create</v-btn>
      <v-progress-circular v-if="requestLoading" :size="25" :color="darkRed" indeterminate></v-progress-circular>
    </div>
  </v-card>
</template>

<script>
export default {
  name: "PostNewItemCard",
  data: () => ({
    valid: false,
    cycle: false,
    rules: {
      required: [v => !!v || "Required."]
    },
    darkRed: "#900028",
    // this could be an object
    // itemName: "",
    // itemSummary: "",
    // itemDescription: "",
    // itemPrice: "",
    // itemCategory: ""
  }),
  methods: {
    create() {
      this.$emit("create");
      //   this.$refs.form.reset();
    }
  },
  props: {
    itemName: String,
    itemSummary: String,
    itemDescription: String,
    itemPrice: String,
    itemCategory: String,

    requestLoading: Boolean
  }
};
</script>

<style>
@import "../../assets/line.css";
</style>