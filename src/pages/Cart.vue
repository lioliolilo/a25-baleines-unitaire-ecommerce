<template>
  <v-container>
    <h1 class="text-h4 font-weight-bold mb-4">Panier</h1>

    <v-card
      v-for="item in cart.items"
      :key="item.id + item.taille"
      class="mb-3 pa-4"
    >
      <div class="d-flex justify-space-between align-center">
        <div>
          <strong>{{ item.nom }}</strong><br />
          Taille : {{ item.taille }}<br />
          {{ item.prix }} $ × {{ item.quantity }}
        </div>

        <div>
          <v-btn icon @click="remove(item.id, item.taille)">
            ✕
          </v-btn>
        </div>
      </div>
    </v-card>

    <h2 class="text-h5 mt-4">
      Total : {{ total }} $
    </h2>

    <v-btn
      color="black"
      class="mt-4"
      :disabled="cart.items.length === 0"
      to="/checkout"
    >
      Passer à la caisse
    </v-btn>
  </v-container>
</template>

<script setup>
import { computed } from 'vue'
import { useCartStore } from '@/stores/cart'

const cart = useCartStore()

const total = computed(() =>
  cart.items.reduce(
    (sum, item) => sum + item.prix * item.quantity, 0
  )
)

function remove(id, taille) {
  cart.removeItem({ id, taille })
}

</script>
