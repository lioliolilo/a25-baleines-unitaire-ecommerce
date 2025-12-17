<template>
  <v-card elevation="2" class="cursor-pointer">
    <v-img :src="product.image" height="260" cover />

    <v-card-title>{{ product.nom }}</v-card-title>
    <v-card-subtitle class="font-weight-bold">
      {{ product.prix }} $
    </v-card-subtitle>

    <v-card-actions>
      <v-btn
        block
        color="black"
        @click="goToProduct"
      >
        Voir le produit
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script setup>
import { useRouter } from 'vue-router'

const props = defineProps({
  product: {
    type: Object,
    required: true
  }
})

const router = useRouter()

function goToProduct() {
  router.push(`/produit/${props.product.id}`)
}
</script>

<style scoped>
.cursor-pointer {
  cursor: pointer;
}
</style>