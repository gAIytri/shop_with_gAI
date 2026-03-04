import { create } from 'zustand'
import type { Product } from '@/types'

interface ProductStore {
  currentProduct: Product | null
  relatedProducts: Product[]
  setCurrentProduct: (product: Product | null) => void
  setRelatedProducts: (products: Product[]) => void
}

export const useProductStore = create<ProductStore>((set) => ({
  currentProduct: null,
  relatedProducts: [],
  setCurrentProduct: (product) => set({ currentProduct: product }),
  setRelatedProducts: (products) => set({ relatedProducts: products }),
}))
