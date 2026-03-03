import { create } from 'zustand'
import type { CartItem, Product } from '@/types'

interface CartStore {
  items: CartItem[]
  couponCode: string | null
  discount: number

  addItem: (product: Product, color: string, size?: string) => void
  removeItem: (itemId: string) => void
  updateQuantity: (itemId: string, quantity: number) => void
  clearCart: () => void
  applyCoupon: (code: string) => void
  removeCoupon: () => void

  subtotal: () => number
  shipping: () => number
  tax: () => number
  total: () => number
  itemCount: () => number
}

export const useCartStore = create<CartStore>((set, get) => ({
  items: [],
  couponCode: null,
  discount: 0,

  addItem: (product, color, size) => {
    const { items } = get()
    const existing = items.find(
      (i) => i.product.id === product.id && i.selectedColor === color && i.selectedSize === size
    )

    if (existing) {
      set({
        items: items.map((i) =>
          i.id === existing.id ? { ...i, quantity: i.quantity + 1 } : i
        ),
      })
    } else {
      set({
        items: [
          ...items,
          {
            id: `cart-${Date.now()}`,
            product,
            selectedColor: color,
            selectedSize: size,
            quantity: 1,
          },
        ],
      })
    }
  },

  removeItem: (itemId) => {
    set({ items: get().items.filter((i) => i.id !== itemId) })
  },

  updateQuantity: (itemId, quantity) => {
    if (quantity <= 0) {
      get().removeItem(itemId)
      return
    }
    set({
      items: get().items.map((i) =>
        i.id === itemId ? { ...i, quantity } : i
      ),
    })
  },

  clearCart: () => set({ items: [], couponCode: null, discount: 0 }),

  applyCoupon: (code) => {
    // Mock: SAVE10 = 10% off, SAVE20 = 20% off
    const discountMap: Record<string, number> = {
      SAVE10: 0.1,
      SAVE20: 0.2,
      FREESHIP: 0,
    }
    const rate = discountMap[code.toUpperCase()]
    if (rate !== undefined) {
      set({ couponCode: code.toUpperCase(), discount: rate })
    }
  },

  removeCoupon: () => set({ couponCode: null, discount: 0 }),

  subtotal: () => get().items.reduce((sum, i) => sum + i.product.price * i.quantity, 0),

  shipping: () => {
    if (get().couponCode === 'FREESHIP') return 0
    return get().subtotal() > 100 ? 0 : 9.99
  },

  tax: () => get().subtotal() * 0.08,

  total: () => {
    const sub = get().subtotal()
    const discountAmount = sub * get().discount
    return sub - discountAmount + get().shipping() + get().tax()
  },

  itemCount: () => get().items.reduce((sum, i) => sum + i.quantity, 0),
}))
