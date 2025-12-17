/**
 * router/index.ts
 *
 * Routes automatiques pour `./src/pages/*.vue`
 */

import { createRouter, createWebHistory } from 'vue-router'

// Pages
import Home from '@/pages/Home.vue'
import Catalogue from '@/pages/Catalogue.vue'
import Product from '@/pages/Product.vue'
import Cart from '@/pages/Cart.vue'
import Checkout from '@/pages/Checkout.vue'

// Création du router
const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/catalogue', component: Catalogue },
    { path: '/produit/:id', component: Product },
    { path: '/cart', component: Cart },
    { path: '/checkout', component: Checkout }
  ],
})

// Gestion des erreurs de module dynamique (Vite + Vuetify)
router.onError((err, to) => {
  if (err?.message?.includes?.('Failed to fetch dynamically imported module')) {
    if (localStorage.getItem('vuetify:dynamic-reload')) {
      console.error('Dynamic import error, reloading did not fix it', err)
    } else {
      console.log('Reloading page to fix dynamic import error')
      localStorage.setItem('vuetify:dynamic-reload', 'true')
      location.assign(to.fullPath)
    }
  } else {
    console.error(err)
  }
})

// Nettoyage après le chargement complet
router.isReady().then(() => {
  localStorage.removeItem('vuetify:dynamic-reload')
})

export default router
