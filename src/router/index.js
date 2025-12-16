/**
 * router/index.ts
 *
 * Automatic routes for `./src/pages/*.vue`
 */

// Composables
import { createRouter, createWebHistory } from 'vue-router'

import Home from '@/pages/Home.vue'
import Catalogue from '@/pages/Catalogue.vue'
import Product from '@/pages/Product.vue'
import Cart from '@/pages/Cart.vue'
import Checkout from '@/pages/Checkout.vue'

// Workaround for https://github.com/vitejs/vite/issues/11804
router.onError((err, to) => {
  if (err?.message?.includes?.('Failed to fetch dynamically imported module')) {
    if (localStorage.getItem('vuetify:dynamic-reload')) {
      console.error('Dynamic import error, reloading page did not fix it', err)
    } else {
      console.log('Reloading page to fix dynamic import error')
      localStorage.setItem('vuetify:dynamic-reload', 'true')
      location.assign(to.fullPath)
    }
  } else {
    console.error(err)
  }
})

router.isReady().then(() => {
  localStorage.removeItem('vuetify:dynamic-reload')
})

export default createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/catalogue', component: Catalogue },
    { path: '/produit/:id', component: Product },
    { path: '/cart', component: Cart },
    { path: '/checkout', component: Checkout },
  ],
})