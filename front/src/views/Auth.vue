<template>
  <v-container class="fill-height">
    <v-row>
      <v-col class>
        <div class="d-flex justify-center align-center">
          <h1>Hello World</h1>
          <p>{{ authMode }}</p>
          <!-- the width is going to have to be resizable -->
          <!-- it is not going to look great for responsive web -->
          <v-card width="400" class="card-signing elevation-2"></v-card>
        </div>
      </v-col>
      <!-- Banner -->
      <!-- <v-snackbar :color="bannerType" :timeout="timeout" v-model="alert">
        {{ bannerText }}
        <v-btn color="white" text @click="alert = false">
          <v-icon>mdi-window-close</v-icon>
        </v-btn>
      </v-snackbar>-->
    </v-row>
  </v-container>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  name: "Auth",
  data: () => ({}),
  computed: {
    ...mapState(["authMode"])
  }
};
</script>

<style>
.card-signing {
  padding: 30px;
}
</style>