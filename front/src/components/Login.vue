<template>
  <v-container class="fill-height">
    <v-row>
      <v-col class>
        <div class="d-flex justify-center align-center">
          <v-card width="400" class="card-signing elevation-2">
            <h1 class="pb-5 text-center">Login</h1>
            <v-form v-model="valid">
              <v-text-field
                :color="themeColor"
                v-model="username"
                :rules="rules"
                autocomplete="username"
                name="signin-username"
                required
                label="Username"
                filled
              ></v-text-field>
              <v-text-field
                v-model="pass"
                :color="themeColor"
                :append-icon="eye ? 'mdi-eye' : 'mdi-eye-off'"
                :type="eye ? 'text' : 'password'"
                :rules="rules"
                autocomplete="new-password"
                required
                filled
                name="signin-password"
                label="Password"
                @click:append="eye = !eye"
                @keyup.enter="login"
              ></v-text-field>
              <v-row>
                <v-col cols="12" class="d-flex justify-center">
                  <!-- <v-col cols="12" md="6" class="d-flex justify-center justify-md-end"> -->
                  <v-btn
                    v-if="!requestLoading"
                    :style="valid ? {transition: `0.3s ease`} : null"
                    :color="valid ? themeColor : null"
                    :class="[valid ? `white--black` : '']"
                    @click="login"
                  >Login</v-btn>
                </v-col>
                <!-- <v-col cols="12" md="6" class="d-flex justify-center justify-md-start">
                  <v-btn
                    v-if="!requestLoading"
                    :style="valid ? {transition: `0.3s ease`} : null"
                    :color="valid ? themeColor : null"
                    :class="[valid ? `white--black` : '']"
                    @click="login"
                  >Login</v-btn>
                </v-col>-->
              </v-row>
            </v-form>
          </v-card>
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
export default {};
</script>

<style>
.card-signing {
  padding: 30px;
}
</style>