<template>
  <v-container v-if="produit">
    <v-row>
      <v-col cols="12" md="6">
        <v-img :src="produit.image" height="500" cover />
      </v-col>

      <v-col cols="12" md="6">
        <h1 class="text-h4 font-weight-bold">{{ produit.nom }}</h1>
        <p class="text-h5 my-4">{{ produit.prix }} $</p>

        <v-select
          v-model="selectedTaille"
          label="Taille"
          :items="produit.tailles || ['Unique']"
          item-title="label"
          item-value="id"
          class="mb-4"
        />

        <v-btn
          color="black"
          size="large"
          class="mt-4"
          :disabled="!selectedTaille"
          @click="addToCart"
        >
          Ajouter au panier
        </v-btn>
      </v-col>
    </v-row>
  </v-container>

  <v-container v-else>
    <h2>Produit introuvable</h2>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useCartStore } from '@/stores/cart'

const cart = useCartStore()
const route = useRoute()

const produit = ref(null)
const selectedTaille = ref(null)
const produits = ref([])

onMounted(async () => {
  try {
    const res = await fetch('/api/product/afficherProduit.php', {
      credentials: 'include'
    })
    const data = await res.json()

    if (data.success) {
      data.produits.forEach(p => {
        p.image = p.image.replace(/^public\//, '/')
        p.image2 = p.image2.replace(/^public\//, '/')
      })

      produits.value = data.produits

      const id = Number(route.params.id)
      produit.value = produits.value.find(p => p.id === id)

      if (produit.value && !produit.value.tailles) {
        produit.value.tailles = ['Unique']
      }
    } else {
      console.error('Erreur API:', data.error)
    }
  } catch (err) {
    console.error('Erreur fetch produit:', err)
  }
})

function addToCart() {
  if (!produit.value || !selectedTaille.value) return

  cart.addItem({
    id: produit.value.id,
    nom: produit.value.nom,
    prix: produit.value.prix,
    image: produit.value.image,
    taille: selectedTaille.value
  })
}
</script>
