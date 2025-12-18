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
      <strong>{{ item.nom }}</strong><br />
      Taille : {{ item.taille }}<br />
      {{ item.prix }} $ × {{ item.quantity }}
    </v-card>

    <h2 class="text-h5 mt-4">
      Total : {{ total }} $
    </h2>

    <v-btn
      color="black"
      class="mt-4"
      :disabled="cart.items.length === 0"
      @click="confirm"
    >
      Confirmer
    </v-btn>
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

async function confirm() {
  try {
    const data = await cart.checkout();
    alert('Commande réussie, ID : ' + data.order_id);
  } catch (error) {
    alert('Erreur API : ' + (error.message || 'Erreur inconnue'));
    console.error(error);
  }
}
</script>