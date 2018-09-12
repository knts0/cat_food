'use strict'


//
import Vue from 'vue/dist/vue.esm.js'
import ElementUI from 'element-ui'
//import 'element-ui/lib/theme-chalk/index.css'
import locale from 'element-ui/lib/locale/lang/ja'

import Router from './router/router'
import Header from './components/header.vue'
//import TimePicker from './components/timepicker.vue'

//Vue.use(ElementUI, { locale })

var app = new Vue({
  router: Router,
  el: '#app',
  components: {
    //'navbar': Header,
    //'timepicker-component': TimePicker
  }
});
