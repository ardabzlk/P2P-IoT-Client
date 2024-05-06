<template>
  <v-container>
    <v-row>
      <v-col cols="12" class="text-right">
        <v-btn icon @click="getWeatherData"><v-icon class="mdi mdi-refresh" color="primary"
            size="48px">mdi-refresh</v-icon>
        </v-btn>
        <p> Hello CI/CD </p>
      </v-col>

      <v-col cols="12">
        <ApexChart ref="AQIChart" type="line" height="350" :options="chartOptionsAQI" :series="seriesAQI"></ApexChart>
      </v-col>
      <v-col cols="12">
        <ApexChart ref="CO2Chart" type="line" height="350" :options="chartOptionsCO2" :series="seriesCO2"></ApexChart>
      </v-col>

      <v-col cols="12">
        <ApexChart ref="TVOCSChart" type="line" height="350" :options="chartOptionsTVOCS" :series="seriesTVOCS">
        </ApexChart>
      </v-col>
      <!-- <v-col cols="12">
        <ApexChart ref="temperatureChart" type="line" height="350" :options="chartOptionsTemperature"
          :series="seriesTemperature"></ApexChart>
      </v-col>

      <v-col cols="12">
        <ApexChart ref="humidityChart" type="line" height="350" :options="chartOptionsHumidity"
          :series="seriesHumidity"></ApexChart>
      </v-col> -->
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';
import ApexChart from 'vue-apexcharts';

export default {
  name: 'DashboardPage',
  components: {
    ApexChart,
  },
  data() {
    return {
      weatherData: [],
      seriesAQI: [],
      seriesCO2: [],
      seriesTVOCS: [],
      seriesTemperature: [],
      seriesHumidity: [],
      chartOptionsAQI: {
        chart: {
          height: 350,
          type: 'line',
        },
        title: {
          text: 'AQI',
          align: 'left'
        },
        grid: {
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
            opacity: 0.5
          },
        },
        xaxis: {
          type: 'timestamp',
          categories: [],
        },
        annotations: {
          background: [
            {
              yaxis: {
                from: 1,
                to: 2,
              },
              backgroundColor: "#ffd700",
            },
          ],
        },
      },
      chartOptionsCO2:
      {
        chart: {
          height: 350,
          type: 'line',
        },
        title: {
          text: 'CO2',
          align: 'left'
        },
        grid: {
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
            opacity: 0.5
          },
        },
        xaxis: {
          type: 'timestamp',
          categories: [],
        },
        annotations: {
              yaxis: [{
                y: 400,
                y2: 1000,
                borderColor: '#000',
                fillColor: '#70ff70',
                opacity: 0.2,
                label: {
                  borderColor: '#333',
                  style: {
                    fontSize: '10px',
                    color: '#fff',
                    background: '#00E396',
                  },
                  text: 'Acceptable',
                }
              }],
            }
      }
      ,
      chartOptionsTVOCS:
      {
        chart: {
          height: 350,
          type: 'line',
        },
        title: {
          text: 'TVOCS',
          align: 'left'
        },
        grid: {
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
            opacity: 0.5
          },
        },
        xaxis: {
          type: 'timestamp',
          categories: [],
        }
      }
      ,
      chartOptionsTemperature:
      {
        chart: {
          height: 350,
          type: 'line',
        },
        title: {
          text: 'Temperature',
          align: 'left'
        },
        grid: {
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
            opacity: 0.5
          },
        },
        xaxis: {
          type: 'timestamp',
          categories: [],
        }
      }
      ,
      chartOptionsHumidity:
      {
        chart: {
          height: 350,
          type: 'line',
        },
        title: {
          text: 'Humidity',
          align: 'left'
        },
        grid: {
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
            opacity: 0.5
          },
        },
        xaxis: {
          type: 'timestamp',
          categories: [],
        }
      }
      ,



    };
  },
  methods: {
    getWeatherData() {
      // Make an Axios GET request to fetch weather data
      axios.get('http://35.203.60.205/api/weather-stats')
        .then(response => {
          // Update the weatherData array with the fetched data
          const data = response.data.data;
          // Format the fetched data
          this.formatData(data);
        })
        .catch(error => {
          console.error('Error fetching weather data:', error);
        });
    },
    timestampToTime(timestamp) {
      // timestamp to human readable time
      var date = new Date(timestamp * 1000);

      var month = date.getMonth() + 1;
      var day = date.getDate();
      // Hours part from the timestamp
      var hours = date.getHours();
      // Minutes part from the timestamp
      var minutes = "0" + date.getMinutes();
      // Seconds part from the timestamp
      // var seconds = "0" + date.getSeconds();
      // Will display time in 10:30:23 format
      var formattedTime = month+ '/' + day + ' '+ hours + ':' + minutes.substr(-2)
      return formattedTime;

    },

    formatData(_data) {
      try {
        // Extract the required data from the fetched data
        const labels = _data.map(data => this.timestampToTime(data.timestamp));
        const seriesAQI = _data.map(data => data.aqi.value);
        const seriesCO2 = _data.map(data => data.co2.value);
        const seriesTVOCS = _data.map(data => data.tvoc.value);
        const seriesTemperature = _data.map(data => data.temperature.value);
        const seriesHumidity = _data.map(data => data.humidity.value);
        // Return the formatted data

        // timestamp: seriesAQI
        // Update the seriesAQI array with the formatted data
        this.seriesAQI = [{ data: seriesAQI }];
        this.chartOptionsAQI.xaxis.categories = labels;

        this.seriesCO2 = [{ data: seriesCO2 }];
        this.chartOptionsCO2.xaxis.categories = labels;

        this.seriesTVOCS = [{ data: seriesTVOCS }];
        this.chartOptionsTVOCS.xaxis.categories = labels;

        this.seriesTemperature = [{ data: seriesTemperature }];
        this.chartOptionsTemperature.xaxis.categories = labels;

        this.seriesHumidity = [{ data: seriesHumidity }];
        this.chartOptionsHumidity.xaxis.categories = labels;

        this.$refs.AQIChart.refresh();
        this.$refs.CO2Chart.refresh();
        this.$refs.TVOCSChart.refresh();
        this.$refs.temperatureChart.refresh();
        this.$refs.humidityChart.refresh();

      } catch (error) {
        console.log('Error formatting data:', error);
      }

    },

    loopData() {
      
      setInterval(() => {
        this.getWeatherData();
      }, 60000); // 1 minute is 60000 milliseconds
    },
  },
  mounted() {
    this.getWeatherData();

    // Fetch weather data when the component is mounted
    this.loopData();

  },

};
</script>

<style lang="scss"></style>
