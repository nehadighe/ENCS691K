<template>
  <div id="parent_div" class>
    <v-container>
      <v-row>
        <v-col class cols="12" md="4">
          <v-card class="pa-5">
            <div class>
              <v-form ref="form" v-model="valid">
                <div id="upload">
                  <div
                    v-if="item.images.length < 1"
                    class="mb-5 dropbox dropbox-without-image d-flex justify-center align-center"
                  >
                    <input
                      type="file"
                      multiple
                      :disabled="isSaving"
                      @change="uploadImage"
                      accept="image/*"
                      class="input-file"
                    />
                    <div class="pa-2 d-flex flex-row imageContainer">
                      <v-icon small class="white--text">mdi-account-box-multiple</v-icon>
                      <p class="mb-0 ml-1">Add Images</p>
                    </div>
                  </div>
                  <div
                    v-if="item.images.length > 0"
                    class="mb-5 dropbox d-flex justify-center align-center"
                  >
                    <input
                      type="file"
                      multiple
                      :disabled="isSaving"
                      @change="uploadImage"
                      accept="image/*"
                      class="input-file"
                    />
                    <v-row class="pa-5">
                      <v-col class cols="4" v-for="(item, index) in item.images" :key="index">
                        <v-img contain aspect-ratio="1" :src="item.path">
                          <template v-slot:placeholder v-if="isSaving">
                            <v-row class="fill-height ma-0" align="start" justify="end">
                              <v-progress-circular :size="20" indeterminate color="grey lighten-5"></v-progress-circular>
                            </v-row>
                          </template>
                          <template v-if="!isSaving">
                            <v-row class="fill-height ma-0" align="start" justify="end">
                              <v-btn icon @click="deleteImage(item)">
                                <v-icon small class="pa-1 white--text">mdi-close-circle</v-icon>
                              </v-btn>
                              <!-- <p class="mb-0 white--text">X</p> -->
                              <!-- <v-progress-circular :size="20" indeterminate color="grey lighten-5"></v-progress-circular> -->
                            </v-row>
                          </template>
                        </v-img>
                      </v-col>
                    </v-row>
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
                    <v-carousel-item v-for="(item, index) in item.images" :key="index">
                      <v-img contain aspect-ratio="1.5" :src="item.path" />
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
// import PostNewItemCard from "@/components/Item/PostNewItemCard.vue";
import { Storage } from "aws-amplify";
import { v4 as uuidv4 } from "uuid";
// import ItemService from "@/services/Item";
import { mapState, mapActions } from "vuex";

const STATUS_SAVING = 1,
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

    requestLoading: false,
    categories: ["Electronics", "Home Goods"],

    // uploading to s3
    currentStatus: null,
    bucket: "encs691k-item-images155906-dev",

    // pop up message
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null
  }),
  computed: {
    ...mapState(["authUser"]),
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
        // var location = `${file.name}`;
        Storage.put(location, file, {
          contentType: file.type
        })
          .then(result => {
            // console.log(result.key);
            // public could be a variable
            var path = `https://${this.bucket}.s3.amazonaws.com/public/${result.key}`;
            var imageObj = {
              id: file.name,
              path: path
            };
            this.item.images.push(imageObj);
            // this.currentStatus = STATUS_SUCCESS;
          })
          .catch(err => {
            console.log(err);
            // this.currentStatus = STATUS_SUCCESS;
          });
      }
      // console.log("line 206-", this.item.images);
    },
    deleteImage(item) {
      var location = `${this.authUser.username}/${this.item.id}/${item.id}`;
      this.item.images.splice(this.item.images.indexOf(item), 1);
      Storage.remove(location).catch(err => {
        console.log(err);
      });
    },
    async create() {
      this.requestLoading = true;
      this.item.availability = "Active";
      this.item.currentNumberOfBidding = 0;
      this.item.basePrice = parseInt(this.item.basePrice);
      this.item.username = this.authUser.username;
      console.log("line 260 - post_item", this.item);

      // testing portion
      (this.text = "Your item has been created. Posting it!"),
        (this.color = "green"),
        (this.alert = true);
      this.requestLoading = false;

      // actual implementation
      // await ItemService.post(this.item)
        // .then(() => {
        //   this.postItem(this.item); // saving item to store
        //   this.$router.push({ name: "home" });
        //   (this.text = "Your item has been created. Posting it!"),
        //     (this.color = "green"),
        //     (this.alert = true);
        //   this.requestLoading = false;
        // })
        // .catch(err => {
        //   console.log("line 146 err from API call- ", err);
        //   (this.text = "An occured while creating your item"),
        //     (this.color = "#900028"),
        //     (this.alert = true);
        //   this.requestLoading = false;
        // });

      // request loading change
      this.requestLoading = false;
    }
  },
  components: {
    // PostNewItemCard
  },
  mounted() {
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
}

.dropbox-without-image {
  cursor: pointer;
  transition: ease-in 200ms;
}

.dropbox-without-image:hover {
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