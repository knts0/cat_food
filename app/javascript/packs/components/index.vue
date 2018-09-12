<template>
  <div>
    <!-- 新規作成部分 -->
    <div>
      <!--<div>
        <input class="form-control" placeholder="Add your task!!">
      </div>
      <div class="col s2 m1">
        <div class="btn-floating waves-effect waves-light red">
          <i class="material-icons">add</i>
        </div>
      </div>-->
    </div>
    <!-- リスト表示部分 -->
    <div>
      <table>
        <thead>
          <tr>
            <th>時刻</th>
            <th>猫1</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="log in logs" class="collection-item">
          </tr>
          <tr v-for="(value, key) in time_logs" class="collection-item">
            <td>{{ key }}</td>

            <td>
              <label v-if="!value.done"><button v-on:click="createLog(key)">x</button></label>
              <label v-if="value.done"><button v-on:click="deleteLog(key)">o</button></label>
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
        logs: [],
        ids: {},
        time_logs: {},
        newLog: '',
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
          for (var time of array) {
            this.time_logs[time] = {};
            this.time_logs[time]['done'] = false;
            this.time_logs[time]['log_id'] = undefined;
            this.ids[time] = undefined;
          }
          for (var log of this.logs) {
            console.log(log['fed_at']);
            this.time_logs[log['fed_at']]['done'] = true;
            this.time_logs[log['fed_at']]['log_id'] = log.id;
            this.ids[time] = log.id;
            //console.log(this.ids[time] + ": " + this.time_logs[log['fed_at']]);
          };
          /*for (var key in this.time_logs) {
            console.log("key is: " + key);
            console.log("done is: " + this.time_logs[key]['done']);
            console.log("log_id is: " + this.time_logs[key]['log_id'] + "\n");
          }*/

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
          //console.log(this.time_logs[fed_at]);
        }, (error) => {
          console.log(error);
        });
      },
      deleteLog: function (fed_at) {
        this.logs.forEach( function(log) {
          console.log(log);
        });
        //console.log(this.time_logs.filter( (log) => log['fed_at'] === fed_at));
        //var log = this.time_logs.filter( (log) => log['fed_at'] === fed_at)[0];
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
