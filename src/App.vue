<template>
  <v-app>
    <Navbar />

    <v-main>
      <router-view />
    </v-main>

    <Footer />
  </v-app>
</template>

<script setup>
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/AppFooter.vue'
</script>
