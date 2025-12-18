import { defineStore } from 'pinia'

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: JSON.parse(localStorage.getItem('cart')) || []
  }),

  getters: {
    totalItems: state => state.items.reduce((sum, item) => sum + item.quantity, 0),
    totalPrice: state => state.items.reduce((sum, item) => sum + item.prix * item.quantity, 0)
  },

  actions: {
    addItem(product) {
      const existing = this.items.find(
        item => item.id === product.id && item.taille === product.taille
      )
      if (existing) existing.quantity++
      else this.items.push({ ...product, quantity: 1 })

      localStorage.setItem('cart', JSON.stringify(this.items))
    },

    updateQuantity(productId, taille, quantity) {
      const item = this.items.find(item => item.id === productId && item.taille === taille)
      if (item) {
        if (quantity <= 0) this.removeItem({ id: productId, taille })
        else {
          item.quantity = quantity
          localStorage.setItem('cart', JSON.stringify(this.items))
        }
      }
    },

    removeItem(product) {
      this.items = this.items.filter(
        item => !(item.id === product.id && item.taille === product.taille)
      )
      localStorage.setItem('cart', JSON.stringify(this.items))
    },

    async checkout() {
      const response = await fetch('/api/orders/create.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ items: this.items })
      })

      const text = await response.text()
      let data
      try { data = JSON.parse(text) } 
      catch { throw new Error('Réponse serveur invalide : ' + text) }

      if (!response.ok || data.error) throw new Error(data.error || 'Erreur lors de la création de la commande')

      this.items = []
      localStorage.removeItem('cart')
      return data
    }
  }
})
