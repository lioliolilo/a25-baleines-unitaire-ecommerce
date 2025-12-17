<template>
  <v-container>
    <h1 class="text-h4 font-weight-bold mb-4">
      Validation du panier
    </h1>

    <v-card
      v-for="item in cart.items"
      :key="item.id + item.taille"
      class="mb-3 pa-4"
    >
      <div class="d-flex justify-space-between">
        <div>
          <strong>{{ item.nom }}</strong><br />
          Taille : {{ item.taille }}<br />
          {{ item.prix }} $ × {{ item.quantity }}
        </div>

        <div>
          {{ item.prix * item.quantity }} $
        </div>
      </div>
    </v-card>

    <h2 class="text-h5 mt-4">
      Total : {{ total }} $
    </h2>

    <div class="mt-6">
      <v-btn
        color="grey"
        variant="outlined"
        to="/cart"
        class="mr-3"
      >
        Retour au panier
      </v-btn>

      <v-btn
        color="black"
        :disabled="cart.items.length === 0"
        @click="confirmCheckout"
      >
        Confirmer et payer
      </v-btn>
    </div>
  </v-container>
</template>

<script setup>
import { computed } from 'vue'
import { useCartStore } from '@/stores/cart'

const cart = useCartStore()

const total = computed(() =>
  cart.items.reduce(
    (sum, item) => sum + item.prix * item.quantity,
    0
  )
)

function confirmCheckout() {
  console.log('Panier validé :', cart.items)
  // post to API endpoint to create order
}
</script>
