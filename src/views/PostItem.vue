<template>
  <div id="parent_div" class>
    <v-container>
      <v-row>
        <v-col class cols="12" md="4">
          <v-card class="pa-5">
            <div class>
              <v-form ref="form" v-model="valid">
                <div id="upload">
                  <div v-if="item.images.length < 1" class="mb-5 dropbox d-flex justify-center align-center">
                    <input
                      type="file"
                      multiple
                      :name="uploadFieldName"
                      :disabled="isSaving"
                      @change="uploadImage"
                      accept="image/*"
                      class="input-file"
                    />
                    <div class="pa-2 d-flex flex-row imageContainer">
                      <v-icon small class="white--text">mdi-account-box-multiple</v-icon>
                      <p class="mb-0 ml-1" v-if="isInitial">Add Images</p>
                    </div>
                    <p class="mb-0" v-if="isSaving">Uploading {{ fileCount }} files...</p>
                  </div>
                  <div v-if="item.images.length > 0" class="mb-5 dropbox d-flex justify-center align-center">
                    <input
                      type="file"
                      multiple
                      :name="uploadFieldName"
                      :disabled="isSaving"
                      @change="uploadImage"
                      accept="image/*"
                      class="input-file"
                    />
                    <div v-for="(item, index) in item.images" :key="index">
                      <v-img
                        contain aspect-ratio=".7" :src="image"
                      />
                    </div>
                  </div>
                </div>
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
              <v-progress-circular v-if="requestLoading" :size="25" :color="darkRed" indeterminate></v-progress-circular>
            </div>
          </v-card>
        </v-col>
        <v-col md="8" class="hidden-sm-and-down">
          <div class="d-flex flex-column align-center">
            <v-card class="pa-7" width="600">
              <div id="inside_items">
                <p class="mb-4">Preview</p>
                <!-- carousel -->
                <div v-if="item.images.length > 0" class="ma-3">
                  <v-carousel
                    :continuous="false"
                    :cycle="cycle"
                    :show-arrows="false"
                    hide-delimiter-background
                    delimiter-icon="mdi-circle"
                    height="100%"
                  >
                    <!-- <v-carousel-item v-for="(image, i) in foo" :key="i"> -->
                    <v-carousel-item v-for="(image, i) in item.images" :key="i">
                      <v-img contain aspect-ratio="1.5" :src="image" />
                    </v-carousel-item>
                  </v-carousel>
                </div>
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
import { Storage } from "aws-amplify";
import { v4 as uuidv4 } from "uuid";
import ItemService from "@/services/Item";
import { mapState, mapActions } from "vuex";

const STATUS_INITIAL = 0,
  STATUS_SAVING = 1,
  STATUS_SUCCESS = 2,
  STATUS_FAILED = 3;

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
      id: "",
      title: "",
      images: [],
      basePrice: "",
      summary: "",
      category: "",
      description: ""
    },

    foo: [
      "https://encs691k-item-images155906-dev.s3.amazonaws.com/public/xoo/1bbcd6f2-15ea-42fc-ad5b-201f2be8bf24/airpods.jpg",
      "https://encs691k-item-images155906-dev.s3.amazonaws.com/public/xoo/1bbcd6f2-15ea-42fc-ad5b-201f2be8bf24/airpods.jpg",
      "https://encs691k-item-images155906-dev.s3.amazonaws.com/public/xoo/1bbcd6f2-15ea-42fc-ad5b-201f2be8bf24/airpods.jpg"
    ],

    requestLoading: false,
    categories: ["Electronics", "Home Goods"],

    uploadedFiles: [],
    uploadError: null,
    currentStatus: null,
    uploadFieldName: "photos",
    bucket: "encs691k-item-images155906-dev"
  }),
  computed: {
    ...mapState(["authUser"]),
    isInitial() {
      return this.currentStatus === STATUS_INITIAL;
    },
    isSaving() {
      return this.currentStatus === STATUS_SAVING;
    },
    isSuccess() {
      return this.currentStatus === STATUS_SUCCESS;
    },
    isFailed() {
      return this.currentStatus === STATUS_FAILED;
    }
  },
  methods: {
    ...mapActions(["postItem"]),
    uploadImage() {
      // this.currentStatus = STATUS_SAVING;
      for (var i = 0; i < event.target.files.length; i++) {
        let file = event.target.files[i];
        var location = `${this.authUser.username}/${this.item.id}/${file.name}`;
        Storage.put(location, file, {
          contentType: file.type
        })
          .then(result => {
            console.log(result.key);
            // public could be a variable
            var path = `https://${this.bucket}.s3.amazonaws.com/public/${result.key}`;
            this.item.images.push(path);
            // this.currentStatus = STATUS_SUCCESS;
          })
          .catch(err => {
            console.log(err);
            // this.currentStatus = STATUS_SUCCESS;
          });
      }
      console.log("line 206-", this.item.images);
    },
    reset() {
      // reset form to initial state
      this.currentStatus = STATUS_INITIAL;
      this.uploadedFiles = [];
      this.uploadError = null;
    },
    async create() {
      this.requestLoading = true;
      this.item.images = [
        "https://encs691k-assets.s3.ca-central-1.amazonaws.com/item_images/test_images/bikes1.jpg",
        "https://encs691k-assets.s3.ca-central-1.amazonaws.com/item_images/test_images/bikes2.jpg"
      ];
      this.item.availability = "Active";
      this.item.currentNumberOfBidding = 0;
      this.item.basePrice = parseInt(this.item.basePrice);
      this.item.username = console.log("line 139 - post_item", this.item);
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
  },
  mounted() {
    this.reset();
    this.item.id = uuidv4();
  }
};
</script>

<style>
@import "../assets/line.css";

.dropbox {
  color: white;
  min-height: 150px;
  position: relative;
  border-radius: 10px;
  border-color: grey;
  border-style: solid;
  border-width: thin;
  cursor: pointer;
  transition: ease-in 200ms;
}

.dropbox:hover {
  transition: ease-in 200ms;
  background-color: #c4c4c4;
}

.input-file {
  opacity: 0; /* invisible but it's there! */
  width: 100%;
  height: 100%;
  position: absolute;
  cursor: pointer;
}

.dropbox p {
  font-size: 0.9em;
  text-align: center;
  /* padding: 50px 0; */
}

.imageContainer {
  background-color: grey;
  border-radius: 5px;
}
</style>