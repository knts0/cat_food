<template>
  <div id="timepicker">
    <el-time-select
      v-model="time"
      :picker-options="{
        start: '08:00',
        step: '01:00',
        end: '22:00'
      }"
      placeholder="Select time">
    </el-time-select>
  </div>
</template>

<script>
  export default {
    name: 'timepicker',
    data() {
      return {
        fed_at: ''
      };
    }
  }
</script>
