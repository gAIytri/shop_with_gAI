export interface Product {
  id: string
  sku: string
  name: string
  slug: string
  description: string
  price: number
  compareAtPrice: number | null
  currency: string
  categoryId: string
  categorySlug: string
  categoryName: string
  productTypeId: string
  productTypeName: string
  stockQuantity: number
  stockStatus: 'in_stock' | 'low_stock' | 'out_of_stock' | 'pre_order'
  attributes: ProductAttributes
  images: ProductImage[]
  isFeatured: boolean
  isBestseller: boolean
  avgRating: number
  reviewCount: number
  tags: string[]
  enrichedDescription: EnrichedDescription
  createdAt: string
}

export interface ProductAttributes {
  color: string[]
  material: string[]
  style: string[]
  room: string[]
  [key: string]: string[]
}

export interface ProductImage {
  id: string
  url: string
  alt: string
  isPrimary: boolean
  displayOrder: number
}

export interface EnrichedDescription {
  short: string
  long: string
  features: string[]
  careInstructions: string
}

export interface Category {
  id: string
  name: string
  slug: string
  description: string
  imageUrl: string
  displayOrder: number
  productTypes: ProductType[]
  productCount: number
}

export interface ProductType {
  id: string
  name: string
  slug: string
  categoryId: string
}

export interface CartItem {
  id: string
  product: Product
  selectedColor: string
  selectedSize?: string
  quantity: number
}

export interface Order {
  id: string
  orderNumber: string
  items: OrderItem[]
  status: 'pending' | 'confirmed' | 'processing' | 'shipped' | 'delivered' | 'cancelled' | 'returned'
  subtotal: number
  shipping: number
  tax: number
  discount: number
  total: number
  shippingAddress: Address
  createdAt: string
  updatedAt: string
}

export interface OrderItem {
  id: string
  productName: string
  productImage: string
  selectedColor: string
  selectedSize?: string
  quantity: number
  unitPrice: number
}

export interface Address {
  id: string
  label: string
  firstName: string
  lastName: string
  street1: string
  street2?: string
  city: string
  state: string
  zipCode: string
  country: string
  phone: string
  isDefault: boolean
}

export interface User {
  id: string
  email: string
  firstName: string
  lastName: string
  phone?: string
  avatarUrl?: string
  addresses: Address[]
  createdAt: string
}

export interface Review {
  id: string
  productId: string
  userId: string
  userName: string
  rating: number
  title: string
  body: string
  isVerifiedPurchase: boolean
  createdAt: string
}

export interface FilterState {
  colors: string[]
  materials: string[]
  styles: string[]
  rooms: string[]
  priceRange: [number, number]
  sort: SortOption
  page: number
  perPage: number
}

export type SortOption = 'best-selling' | 'price-asc' | 'price-desc' | 'newest' | 'top-rated'
