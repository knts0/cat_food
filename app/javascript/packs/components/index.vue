<template>
  <div>
    <div>
      <h1>ねこえさログ📝</h1>
      <h4>
        <span style="cursor:pointer;" class="glyphicon glyphicon-chevron-left text-primary" v-on:click="fetchLogs(new Date(date.getFullYear(), date.getMonth(), date.getDate() - 1))"></span>
        {{ date.getFullYear() }}年 {{ date.getMonth() + 1 }}月 {{ date.getDate() }}日
        <span style="cursor:pointer;" class="glyphicon glyphicon-chevron-right text-primary" v-on:click="fetchLogs(new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1))"></span>
      </h4>
    </div>
    <div>
      <table>
        <thead>
          <tr>
            <th class="time-col"></th>
            <th class="cat-col">
              <img src="../../../assets/images/cat1.png" alt="Rails logo" style="width:50px;height:50px;"><br>
              たろう
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(value, key) in time_logs">
            <td class="time-col">{{ key }}</td>

            <td class="cat-col">
                <img v-show="!value.done" src="../../../assets/images/pet_esa_sara_full_gray.png" alt="まだ餌をあげてないよ" style="width:50px;height:50px;cursor:pointer;"  v-on:click="createLog(key)">
                <img v-show="value.done" src="../../../assets/images/pet_esa_sara_full.png" alt="もう餌をあげたよ"  style="width:50px;height:50px;cursor:pointer;" v-on:click="deleteLog(key)">
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
        date: new Date()
      }
    },
    mounted: function () {
      this.fetchLogs(new Date());
    },
    methods: {
      fetchLogs: function (date) {
        this.date = date;
        axios.get('/api/logs', {
          params: {
            year: date.getFullYear(),
            month: date.getMonth()+1,
            date: date.getDate()
          }
        }).then((response) => {
          this.logs = [];
          for(var i = 0; i < response.data.logs.length; i++) {
            this.logs.push(response.data.logs[i]);
          }
          for (var key in this.time_logs) {
            this.time_logs[key]['done'] = false;
            this.time_logs[key]['log_id'] = undefined;
          }
          for (var log of this.logs) {
            this.time_logs[log['fed_at']]['done'] = true;
            this.time_logs[log['fed_at']]['log_id'] = log.id;
          };

        }, (error) => {
          console.log(error);
        });
      },
      createLog: function (fed_at) {
        console.log(new Date(Date.UTC(this.date.getYear(), this.date.getMonth(), this.date.getDate())));
        console.log(new Date(Date.UTC(this.date.getYear(), this.date.getMonth(), this.date.getDate(), Number(fed_at.substr(0,2)), Number(fed_at.substr(3,2)),0, 0)));
        var fed_at_datetime = this.date.getFullYear().toString() + '-' + ('0' + (this.date.getMonth() + 1)).slice(-2).toString() + '-' + ('0' + this.date.getDate()).slice(-2) + ' ' + fed_at;
        axios.post('/api/logs', {
          cat_id: 1,
          feed_id: 1,
          fed_at: fed_at_datetime
        }).then((response) => {
          this.logs.unshift(response.data.log);
          this.time_logs[fed_at]['done'] = true;
          this.time_logs[fed_at]['log_id'] = response.data.log.id;
        }, (error) => {
          console.log(error);
        });
      },
      deleteLog: function (fed_at) {
        var log_id = this.time_logs[fed_at]['log_id'];

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
