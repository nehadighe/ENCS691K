<template>
  <div id="parent_div" class>
    <v-container>
      <v-row>
        <v-col class cols="12" md="4">
          <v-card class="pa-5">
            <div class>
              <v-form ref="form" v-model="valid">
                <v-text-field
                  :color="darkRed"
                  v-model="item.title"
                  :rules="rules.required"
                  name="item-title"
                  label="Title"
                  filled
                ></v-text-field>
                <v-text-field
                  :color="darkRed"
                  v-model="item.basePrice"
                  type="number"
                  :rules="rules.required"
                  prepend-inner-icon="mdi-currency-usd"
                  name="item-price"
                  label="Price"
                  filled
                ></v-text-field>
                <v-select
                  :color="darkRed"
                  :items="categories"
                  filled
                  label="Category"
                  v-model="item.category"
                  :rules="rules.required"
                ></v-select>
                <v-textarea
                  :color="darkRed"
                  :rules="rules.required"
                  v-model="item.summary"
                  filled
                  counter
                  maxlength="100"
                  name="item-summary"
                  label="Summary"
                  auto-grow
                  rows="2"
                  row-height="20"
                ></v-textarea>
                <v-textarea
                  :color="darkRed"
                  filled
                  auto-grow
                  label="Description"
                  v-model="item.description"
                  rows="2"
                  row-height="20"
                ></v-textarea>
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
              <v-progress-circular
                v-if="requestLoading"
                :size="25"
                :color="darkRed"
                indeterminate
              ></v-progress-circular>
            </div>
          </v-card>
        </v-col>
        <v-col md="8" class="hidden-sm-and-down">
          <div class="d-flex flex-column align-center">
            <v-card class="pa-7" width="600">
              <div id="inside_items">
                <p class="mb-4">Preview</p>
                <div id="header" class="pb-5">
                  <h2 class>Title: {{item.title}}</h2>
                  <h3 class>${{item.basePrice}}</h3>
                  <p class="mb-0">Category: {{item.category}}</p>
                </div>
                <div id="body">
                  <p class>Summary</p>
                  <p class="mx-5">{{item.summary}}</p>
                  <p class>Description</p>
                  <p class="mx-5">{{item.description}}</p>
                </div>
              </div>
            </v-card>
          </div>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
// import PostNewItemCard from "@/components/Item/PostNewItemCard.vue";
import ItemService from "@/services/Item";
import { mapActions } from "vuex";

export default {
  name: "NewItem",
  data: () => ({
    valid: false,
    cycle: false,
    rules: {
      required: [v => !!v || "Required."]
    },
    darkRed: "#900028",

    item: {
      title: "",
      basePrice: "",
      summary: "",
      category: "",
      description: ""
    },

    requestLoading: false,
    categories: ["Electronics", "Home Goods"]
  }),
  methods: {
    ...mapActions(["postItem"]),
    async create() {
      this.requestLoading = true;
      this.item.images = [
        "https://encs691k-assets.s3.ca-central-1.amazonaws.com/item_images/test_images/bikes1.jpg",
        "https://encs691k-assets.s3.ca-central-1.amazonaws.com/item_images/test_images/bikes2.jpg"
      ];
      this.item.availability = "Active";
      this.item.currentNumberOfBidding = 0;
      this.item.basePrice = parseInt(this.item.basePrice);
      this.item.username =  
      console.log("line 139 - post_item", this.item);
      // I need to pass the username info
      await ItemService.post(this.item)
        .then(() => {
          this.postItem(this.item);
          this.$router.push({ name: "home" });
        })
        .catch(err => {
          console.log("line 146 err from API call- ", err);
        });
      this.requestLoading = false;
    }
  },
  components: {
    // PostNewItemCard
  }
};
</script>

<style>

@import "../assets/line.css";
</style>