import { create } from 'zustand'
import type { Product } from '@/types'

interface WishlistStore {
  items: Product[]
  addItem: (product: Product) => void
  removeItem: (productId: string) => void
  isInWishlist: (productId: string) => boolean
}

export const useWishlistStore = create<WishlistStore>((set, get) => ({
  items: [],

  addItem: (product) => {
    if (!get().isInWishlist(product.id)) {
      set({ items: [...get().items, product] })
    }
  },

  removeItem: (productId) => {
    set({ items: get().items.filter((p) => p.id !== productId) })
  },

  isInWishlist: (productId) => get().items.some((p) => p.id === productId),
}))
