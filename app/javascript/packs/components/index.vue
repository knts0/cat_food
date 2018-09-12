<template>
  <div>
    <div>
      <h1>ねこえさログ</h1>
    </div>
    <!-- リスト表示部分 -->
    <div>
      <table class="table table-striped table-bordered" style="table-layout:fixed;">
        <thead>
          <tr>
            <th class="col-md-2"></th>
            <th class="col-md-3">
              <img src="../../../assets/images/cat1.png" alt="Rails logo" style="width:70px;height:70px;"><br>
              猫1
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(value, key) in time_logs">
            <td class="col-md-2">{{ key }}</td>

            <td class="col-md-3">
                <img v-show="!value.done" src="../../../assets/images/pet_esa_sara_full_gray.png" alt="まだ餌をあげてないよ" style="width:70px;height:70px;" v-on:click="createLog(key)">
                <!--<button v-on:click="createLog(key)">x</button>-->
                <img v-if="value.done" src="../../../assets/images/pet_esa_sara_full.png" alt="もう餌をあげたよ" style="width:70px;height:70px;" v-on:click="deleteLog(key)">
                <!--<button v-on:click="deleteLog(key)">o</button>-->
              </label>
            </td>

          </tr>

        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function () {
      return {
        time_logs: {
          '08:00': {'done': false, 'log_id': undefined},
          '09:00': {'done': false, 'log_id': undefined},
          '10:00': {'done': false, 'log_id': undefined},
          '11:00': {'done': false, 'log_id': undefined},
          '12:00': {'done': false, 'log_id': undefined},
          '13:00': {'done': false, 'log_id': undefined},
          '14:00': {'done': false, 'log_id': undefined},
          '15:00': {'done': false, 'log_id': undefined},
          '16:00': {'done': false, 'log_id': undefined},
          '17:00': {'done': false, 'log_id': undefined},
          '18:00': {'done': false, 'log_id': undefined},
          '19:00': {'done': false, 'log_id': undefined},
          '20:00': {'done': false, 'log_id': undefined},
          '21:00': {'done': false, 'log_id': undefined},
          '22:00': {'done': false, 'log_id': undefined}
          },
        logs: [],
      }
    },
    mounted: function () {
      this.fetchLogs();
    },
    methods: {
      fetchLogs: function () {
        axios.get('/api/logs').then((response) => {
          for(var i = 0; i < response.data.logs.length; i++) {
            this.logs.push(response.data.logs[i]);
          }
          var array = ['08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00'];
          for (var log of this.logs) {
            console.log(log['fed_at']);
            this.time_logs[log['fed_at']]['done'] = true;
            this.time_logs[log['fed_at']]['log_id'] = log.id;
          };
          for (var key in this.time_logs) {
            console.log("key is: " + key);
            console.log("done is: " + this.time_logs[key]['done']);
            console.log("log_id is: " + this.time_logs[key]['log_id'] + "\n");
          }

        }, (error) => {
          console.log(error);
        });
      },
      createLog: function (fed_at) {
        axios.post('/api/logs', {
          cat_id: 1,
          feed_id: 1,
          fed_at: fed_at
        }).then((response) => {
          this.logs.unshift(response.data.log);
          this.time_logs[fed_at]['done'] = true;
          console.log(response.data.log.id);
          this.time_logs[fed_at]['log_id'] = response.data.log.id;
        }, (error) => {
          console.log(error);
        });
      },
      deleteLog: function (fed_at) {
        this.logs.forEach( function(log) {
          console.log(log);
        });
        var log_id = this.time_logs[fed_at]['log_id'];
        console.log(log_id);

        axios.delete('/api/logs/' + log_id).then((response) => {
          var idx = this.logs.findIndex( function(log) {
            log['fed_at'] === fed_at;
          });
          this.logs.splice(idx, 1);
          this.time_logs[fed_at]['done'] = false;
          this.time_logs[fed_at]['log_id'] = undefined;
        }, (error) => {
          console.log(error);
        });
      },
    }
  }
</script>
