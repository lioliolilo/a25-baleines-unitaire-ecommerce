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
          :items="produit.tailles"
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

const produits = [
  {
    id: 1,
    nom: 'Cravate Unicorne',
    prix: 129,
    image: '/images/tieX.webp',
    tailles: ['Unique'],
  },
  {
    id: 2,
    nom: 'Chemise Unicorne',
    prix: 249,
    image: '/images/shirt1.webp',
    tailles: ['S', 'M', 'L'],
  },
]

onMounted(() => {
  const id = Number(route.params.id)
  produit.value = produits.find(p => p.id === id)
})

function addToCart() {
  cart.addItem({
    id: produit.value.id,
    nom: produit.value.nom,
    prix: produit.value.prix,
    image: produit.value.image,
    taille: selectedTaille.value
  })
}
</script>
