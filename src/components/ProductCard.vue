<template>
  <v-card elevation="2">
    <v-img :src="product.image" height="260" cover />

    <v-card-title>{{ product.nom }}</v-card-title>

    <v-card-subtitle class="font-weight-bold">
      {{ product.prix }} $
    </v-card-subtitle>

    <v-card-actions>
      <v-btn
        block
        color="black"
        :to="`/produit/${product.id}`"
      >
        Voir le produit
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script setup>
defineProps({
  product: Object,
})
</script>
