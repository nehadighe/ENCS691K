<template>
  <v-app-bar :color="headerColor" dark fixed>
    <!-- v-left-icon -->
    <div class="d-flex align-center justify-start clickButton" @click="homeVue()">
      <div>
        <v-img
          alt="Concordia Logo"
          class="shrink mr-2"
          contain
          src="https://encs691k-assets.s3.amazonaws.com/logo.png"
          transition="scale-transition"
          width="40"
        />
      </div>
      <div class="hidden-sm-and-down">
        <!-- <div class="d-flex align-center flex-row hidden-md-and-down"> -->
        <div id="university_and_class">
          <p class="red-font concordia-title text-left mb-0">Concordia</p>
          <p class="red-font class-title text-left mb-0">ENCS691K</p>
        </div>
        <!-- Search functionality should be done here -->
        <!-- <div id="search_bar" v-if="authUser.authenticated">
            <Search class="ml-10 search-area-style"/>
        </div>-->
      </div>
      <div v-if="authUser.authenticated" id="username" class="hidden-md-and-up">
        <v-btn text @click="userVue()" class="user-style">
          <!-- 
              avatar: for now, this is going to be static
              but in teh end, it would be dynamic obtained
              from the store
          -->
          <v-avatar color="indigo" size="36">
            <!-- <v-img src="https://encs691k-assets.s3.amazonaws.com/avatar/Avatar.svg" alt="avatar" /> -->
            <v-img :src="authUser.avatar" alt="avatar" />
          </v-avatar>
        </v-btn>
      </div>
    </div>

    <v-spacer></v-spacer>

    <!-- Unauthenticated users -->
    <div v-if="!authUser.authenticated">
      <!-- Desktop menu -->
      <div class="hidden-sm-and-down">
        <v-btn text @click="authModeLocal('signup')">
          <span class="mr-2">Sign Up</span>
        </v-btn>
        <v-btn text @click="authModeLocal('login')">
          <span class="mr-2">Login</span>
        </v-btn>
      </div>
      <!-- Mobile menu -->
      <v-menu left bottom>
        <template v-slot:activator="{ on }">
          <v-btn class="hidden-md-and-up" icon v-on="on">
            <v-icon class="white--text">mdi-dots-vertical</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-list-item>
            <v-list-item-title @click="authModeLocal('signup')">
              <v-list-item-item class="clickButton">
                <span class="mr-2">Sign Up</span>
              </v-list-item-item>
            </v-list-item-title>
          </v-list-item>
        </v-list>
        <v-list>
          <v-list-item>
            <v-list-item-title @click="authModeLocal('login')">
              <v-list-item-title class="clickButton">
                <span class="mr-2">Login</span>
              </v-list-item-title>
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </div>
    <!-- User Login -->
    <div v-if="authUser.authenticated" class="d-flex flex-row align-center">
      <p
        id="savingButton"
        style="margin-bottom:0px;font-weight:600"
        :ripple="false"
        :class="[savingStatus === 'Saving...' ? `orange--text` : `green--text`]"
        text
      >{{savingStatus}}</p>
      <v-menu offset-y transition="slide-y-transition">
        <template v-slot:activator="{ on, attrs }">
          <v-btn text v-bind="attrs" v-on="on">
            <div id="username" class="hidden-sm-and-down">
              <v-avatar color="indigo" size="36">
                <v-img :src="authUser.avatar" alt="avatar" />
              </v-avatar>
              <span class="mx-2">{{ authUser.username }}</span>
            </div>
          </v-btn>
        </template>
        <v-list>
          <div flat v-for="(item, index) in userFunction" :key="index">
            <v-list-item @click="vListUserFunction(item.option)">
              <v-list-item-title class="clickButton">{{ item.title }}</v-list-item-title>
            </v-list-item>
          </div>
        </v-list>
      </v-menu>
      <v-btn text v-bind="attrs" v-on="on" @click="newItemVue()">
        <v-icon class="icon-size">mdi-plus-circle</v-icon>
      </v-btn>
      <v-menu offset-y transition="slide-y-transition">
        <template v-slot:activator="{ on, attrs }">
          <v-btn text v-bind="attrs" v-on="on">
            <v-icon class="icon-size">mdi-chevron-down-circle</v-icon>
          </v-btn>
        </template>
        <v-list>
          <div flat v-for="(item, index) in itemsFunction" :key="index">
            <v-list-item @click="vListItemFunction(item.option)">
              <v-list-item-title class="clickButton">{{ item.title }}</v-list-item-title>
            </v-list-item>
          </div>
        </v-list>
      </v-menu>
    </div>
    <v-snackbar :color="color" :timeout="snacktimeout" v-model="alert">
      <div class="d-flex flex-row align-center justify-space-between">
        <p class="mb-0">{{ text }}</p>
        <v-btn color="white" text @click="alert = false">
          <v-icon small>mdi-window-close</v-icon>
        </v-btn>
      </div>
    </v-snackbar>
  </v-app-bar>
</template>

<script>
import { Auth } from "aws-amplify";
import { mapActions, mapState } from "vuex";
import { v4 as uuidv4 } from "uuid";
import ItemServices from "@/services/Item";
// import Search from "@/components/Header/Search.vue";

export default {
  name: "Header",
  data: () => ({
    themeColor: "#900028",
    headerColor: "#CDB394",
    attrs: null,
    on: null,
    authenticate: null,
    closeOnContentClick: true,
    itemsFunction: [{ title: "Log Out", option: "1" }],
    userFunction: [
      { title: "Your Items", option: "1" },
      { title: "Bought", option: "2" },
    ],

    // message
    snacktimeout: 8000,
    alert: false,
    text: null,
    color: null
  }),
  components: {
    // Search
  },
  computed: {
    ...mapState(["authUser", "items", "savingStatus", "currentRoute"])
  },
  methods: {
    ...mapActions([
      "resetAppState",
      "authMode",
      "userLogOut",
      "setCurrentRoute"
    ]),
    authModeLocal(event) {
      //   console.log("verifying event", event);
      this.authMode(event);
    },
    bannerMethod(color, text) {
      this.alert = true;
      this.color = color;
      this.text = text;
    },
    homeVue() {
      if (this.currentRoute === "/") console.log("same route");
      else this.$router.push({ name: "home" });
      this.setCurrentRoute("/");
    },
    vListUserFunction(option) {
      // logic to evaluate which local function to call
      if (option === "1") {
        if (this.currentRoute === "userItem") console.log("same route");
        else this.$router.push({ name: "userItem" });
        this.setCurrentRoute("userItem");
      }
      if (option === "2") {
        if (this.currentRoute === "userBoughtItem") console.log("same route");
        else this.$router.push({ name: "userBoughtItem" });
        this.setCurrentRoute("userBoughtItem");
      }
      if (option === "3") {
        if (this.currentRoute === "userProfile") console.log("same route");
        else this.$router.push({ name: "userProfile" });
        this.setCurrentRoute("userProfile");
      }
    },
    async newItemVue() {
      // would have to implement the ItemService here
      // to create a new record
      var item = {
        Images: [],
        id: uuidv4(),
        title: "",
        category: "",
        description: "",
        summary: "",
        availability: "Pending",
        currentNumberOfBidding: "",
        basePrice: "",
        bidPrice: "",
        startBidTime: "",
        ttl: "", // ttl should be enabled
        username: this.authUser.username
      };
      await ItemServices.post(item)
        .then(() => {
          // I am not posting the item inside of the Items state array
          if (this.currentRoute === "editItem") console.log("same route");
          else {
            this.$router.push({
              name: "editItem",
              params: { itemId: item.id }
            });
          }
          this.setCurrentRoute("editItem");
        })
        .catch(err => {
          this.bannerMethod("#900028", err);
        });
    },
    vListItemFunction(option) {
      // logic to evaluate which local function to call
      if (option === "1") {
        this.logOut();
      }
    },
    async logOut() {
      try {
        await Auth.signOut({ global: true });
        // if I reset the app state, everything will be lost
        // it's like resetting the catch
        // this.resetAppState();
        // need to reset authUser as {}
        this.userLogOut();
        console.log('line 260', this.currentRoute)
        if (this.currentRoute === "auth") console.log("same route");
        else this.$router.push({ name: "auth" });
        this.setCurrentRoute("auth");
      } catch (error) {
        console.log("error signing out: ", error);
      }
    }
  },
  mounted() {
    // console.log('line 277', this.authUser, this.currentRoute)
  }
};
</script>

<style>
@import "../assets/line.css";
@import "../assets/colors.css";
@import "../assets/font.css";

.header {
  position: fixed;
  z-index: 1;
}

.clickButton {
  cursor: pointer;
}

.icon-size {
  font-size: 30px !important;
}

.search-area-style {
  width: 20rem;
  /* background-color:red !important; */
}
</style>