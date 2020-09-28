<template>
  <div>
    <h1 class="pb-5 text-center dark-2-golden-font">Verifiaction Code</h1>
    <v-form ref="form" v-model="valid">
      <!-- verification code -->
      <v-text-field
        :color="themeColor"
        v-model="code"
        :rules="rules.required"
        autocomplete="verification"
        name="verification-code"
        label="Verification Code"
        filled
      ></v-text-field>
      <v-btn
        :style="valid ? {transition: `0.3s ease`} : null"
        :color="valid ? themeColor : null"
        :class="[valid ? `white--text` : '']"
        @click="verifyCode()"
      >Verify</v-btn>
      <!-- Conditional styling -->
      <!-- <v-progress-circular
                  v-if="requestLoading"
                  :size="20"
                  :color="themeColor"
                  indeterminate
      ></v-progress-circular>-->
    </v-form>
  </div>
</template>

<script>
export default {
  name: "Verification",
  data: () => ({
    valid: false,
    rules: {
      required: [v => !!v || "Required."]
    },
    code: ""
  }),
  props: {
    themeColor: String
  },
  methods: {
    verifyCode() {
      var event = {
        valid: this.valid,
        code: this.code
      };
      this.$emit("verifyCode", event);
    }
  }
};
</script>

<style>
</style>