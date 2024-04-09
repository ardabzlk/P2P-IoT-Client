import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import VueApexCharts from 'vue-apexcharts'
Vue.use(VueApexCharts)

Vue.config.productionTip = false
Vue.component("ApexChart", VueApexCharts) // Renamed the component to "ApexChart"

new Vue({
  vuetify,
  render: h => h(App)
}).$mount('#app')
