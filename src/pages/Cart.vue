<template>
  <v-container>
    <h1 class="text-h4 font-weight-bold mb-4">Panier</h1>

    <v-card v-for="item in cart" :key="item.id" class="mb-3 pa-4">
      {{ item.nom }} — {{ item.prix }} $
    </v-card>

    <v-btn color="black" to="/checkout">
      Passer à la caisse
    </v-btn>
  </v-container>
</template>

<script setup>
const cart = [
  { id: 1, nom: 'Cravate Unicorne', prix: 129 },
]
</script>
