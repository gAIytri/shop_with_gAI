import type { CartItem } from '@/types'
import { products } from './products'

export const mockCartItems: CartItem[] = [
  {
    id: 'cart-1',
    product: products[1], // Rattan Arc Floor Lamp
    selectedColor: 'Natural',
    quantity: 1,
  },
  {
    id: 'cart-2',
    product: products[17], // Moroccan Diamond Area Rug
    selectedColor: 'Ivory/Charcoal',
    selectedSize: "6' x 9'",
    quantity: 1,
  },
  {
    id: 'cart-3',
    product: products[5], // Bergamot & Cedar Candle
    selectedColor: 'Amber',
    quantity: 2,
  },
]
