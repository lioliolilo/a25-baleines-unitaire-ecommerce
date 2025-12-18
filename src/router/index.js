import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/pages/Home.vue'
import Catalogue from '@/pages/Catalogue.vue'
import Product from '@/pages/Product.vue'
import Cart from '@/pages/Cart.vue'
import Checkout from '@/pages/Checkout.vue'

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

router.onError((err, to) => {
  if (err?.message?.includes?.('Failed to fetch dynamically imported module')) {
    if (localStorage.getItem('vuetify:dynamic-reload')) {
      console.error(err)
    } else {
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

export default router
