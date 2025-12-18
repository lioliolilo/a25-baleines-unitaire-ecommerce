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
import { ref, onMounted } from 'vue'
import ProductCard from '@/components/ProductCard.vue'

const produits = ref([])

onMounted(async () => {
  try {
    const res = await fetch('/api/product/afficherProduit.php', { credentials: 'include' })
    const data = await res.json()
    if (data.success) {
      produits.value = data.produits
    } else {
      console.error('Erreur API:', data.error)
    }
  } catch (err) {
    console.error('Erreur fetch:', err)
  }
})
</script>
