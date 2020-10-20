<template>
  <v-card elevation="3" class="mx-auto my-12" max-width="374">
    <template slot="progress">
      <v-progress-linear color="deep-purple" height="10" indeterminate></v-progress-linear>
    </template>

    <v-carousel
      :continuous="false"
      :cycle="cycle"
      hide-delimiter-background
      show-arrows-on-hover
      delimiter-icon="mdi-minus"
      height="250"
    >
      <v-carousel-item v-for="(image, i) in images" :key="i">
        <v-row class="fill-height" align="center" justify="center">
          <!-- <v-img :src="image"/> -->
          <v-img aspect-ratio="1.9" contain :src="image" />
          <!-- <v-img height="250" :src="image"/> -->
        </v-row>
      </v-carousel-item>
    </v-carousel>

    <v-card-title>{{ name }}</v-card-title>

    <v-card-text>
      <v-row align="center" class="mx-0">
        <v-chip
          class
          :color="availability == 'Available' ? 'green' : 'pink'"
          label
          text-color="white"
        >
          <v-icon small left>mdi-circle</v-icon>
          {{ availability }}
        </v-chip>
      </v-row>

      <div class="my-4 subtitle-1">$ {{ basePrice }} • {{ category }}</div>

      <div>{{ description }}</div>
    </v-card-text>

    <v-divider class="mx-4"></v-divider>

    <v-card-title>Starting price</v-card-title>

    <v-card-text>
      <v-chip-group v-model="selection" active-class="deep-purple accent-4 white--text" column>
        <v-chip>5:30PM</v-chip>

        <v-chip>7:30PM</v-chip>

        <v-chip>8:00PM</v-chip>

        <v-chip>9:00PM</v-chip>
      </v-chip-group>
    </v-card-text>

    <v-card-actions>
      <v-btn color="deep-purple lighten-2" text @click="bid">Bid</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: "ItemCards",
  data: () => ({
    cycle: false,
    selection: null
  }),
  methods: {
    bid() {
      console.log("Hello");
    }
  },
  props: {
    name: String,
    images: Array,
    description: String,
    availability: String,
    basePrice: Number,
    category: String
  }
};
</script>

<style>
</style>