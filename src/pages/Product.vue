<template>
  <v-container>
    <v-row>
      <v-col cols="12" md="6">
        <v-img :src="produit.image" height="500" cover />
      </v-col>

      <v-col cols="12" md="6">
        <h1 class="text-h4 font-weight-bold">{{ produit.nom }}</h1>
        <p class="text-h5 my-4">{{ produit.prix }} $</p>

        <v-select
          label="Taille"
          :items="produit.tailles"
        />

        <v-btn color="black" size="large" class="mt-4">
          Ajouter au panier
        </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
const produit = {
  nom: 'Cravate Unicorne',
  prix: 129,
  image: '/images/tieX.webp',
  tailles: ['Unique'],
}
</script>
