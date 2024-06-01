import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import Casdoor from 'casdoor-vue-sdk'

const config = {
  serverUrl: import.meta.env.VITE_SERVERURL,
  clientId: import.meta.env.VITE_CLIENTID,
  organizationName: import.meta.env.VITE_ORGANIZATIONNAME,
  appName: import.meta.env.VITE_APPNAME,
  redirectPath: import.meta.env.VITE_REDIRECTPATH,
};

console.log(config);


import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(Casdoor, config)

app.mount('#app')
