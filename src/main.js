/**
 * main.js
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

// Plugins
import { registerPlugins } from '@/plugins'

// Components
import App from './App.vue'

// Composables
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'

// Styles
import 'vuetify/styles'
import { createVuetify } from 'vuetify'

const vuetify = createVuetify()

createApp(App)
    .use(createPinia())
    .use(router)
    .use(vuetify)
    .mount('#app')
