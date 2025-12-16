<template>
  <v-container>
    <h1 class="text-h4 font-weight-bold mb-6">Catalogue</h1>

    <v-row>
      <v-col
        v-for="p in produits"
        :key="p.id"
        cols="12"
        sm="6"
        md="4"
      >
        <ProductCard :product="p" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import ProductCard from '@/components/ProductCard.vue'

const produits = [
  {
    id: 1,
    nom: 'Cravate Unicorne',
    prix: 129,
    image: '/images/tieX.webp',
  },
  {
    id: 2,
    nom: 'Chemise Unicorne',
    prix: 249,
    image: '/images/shirt1.webp',
  },
]
</script>
