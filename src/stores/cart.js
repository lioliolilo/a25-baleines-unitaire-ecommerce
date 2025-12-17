import { defineStore } from 'pinia'

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: JSON.parse(localStorage.getItem('cart')) || []
  }),

  getters: {
    totalItems: (state) => {
      return state.items.reduce((sum, item) => sum + item.quantity, 0)
    },
    
    totalPrice: (state) => {
      return state.items.reduce((sum, item) => sum + (item.prix * item.quantity), 0)
    }
  },

  actions: {
    addItem(product) {
      const existing = this.items.find(
        item => item.id === product.id && item.taille === product.taille
      )
      
      if (existing) {
        existing.quantity++
      } else {
        this.items.push({
          ...product,
          quantity: 1
        })
      }

      localStorage.setItem('cart', JSON.stringify(this.items))
    },

    updateQuantity(productId, taille, quantity) {
      const item = this.items.find(
        item => item.id === productId && item.taille === taille
      )
      
      if (item) {
        item.quantity = quantity
        if (item.quantity <= 0) {
          this.removeItem({ id: productId, taille })
        } else {
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

    clearCart() {
      this.items = []
      localStorage.removeItem('cart')
    },

    async checkout() {
      try {
        const response = await fetch('/api/orders/create.php', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          credentials: 'include',
          body: JSON.stringify({
            items: this.items
          })
        })

        const data = await response.json()

        if (!response.ok) {
          throw new Error(data.error || 'Erreur lors de la création de la commande')
        }

        if (data.success) {
          this.clearCart()
          return data
        } else {
          throw new Error('Erreur lors de la création de la commande')
        }
      } catch (error) {
        console.error('Erreur lors du checkout :', error)
        throw error
      }
    }
  }
})