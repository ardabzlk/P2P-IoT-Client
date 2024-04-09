<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center">
        <h3>P2P Weather</h3>
      </div>

      <v-spacer></v-spacer>
    </v-app-bar>

    <v-main>
      <DashboardPage/>
    </v-main>
  </v-app>
</template>

<script>
import DashboardPage from './components/DashboardPage.vue';

export default {
  name: 'App',

  components: {
    DashboardPage,
  },

  data: () => ({
    //
  }),
};
</script>
