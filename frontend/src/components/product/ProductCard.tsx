import { Link } from 'react-router-dom'
import { Heart } from 'lucide-react'
import { Rating } from '@/components/ui/rating'
import { PriceDisplay } from '@/components/ui/price-display'
import { Badge } from '@/components/ui/badge'
import { useWishlistStore } from '@/stores/wishlistStore'
import type { Product } from '@/types'
import { cn } from '@/lib/utils'

interface ProductCardProps {
  product: Product
  className?: string
}

export function ProductCard({ product, className }: ProductCardProps) {
  const { isInWishlist, addItem, removeItem } = useWishlistStore()
  const wishlisted = isInWishlist(product.id)

  const handleWishlistToggle = (e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()
    if (wishlisted) {
      removeItem(product.id)
    } else {
      addItem(product)
    }
  }

  return (
    <Link
      to={`/product/${product.slug}`}
      className={cn('group block', className)}
    >
      {/* Image container */}
      <div className="relative aspect-square overflow-hidden bg-surface mb-3">
        <img
          src={product.images[0]?.url}
          alt={product.images[0]?.alt || product.name}
          className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
          loading="lazy"
        />
        {/* Second image on hover */}
        {product.images[1] && (
          <img
            src={product.images[1].url}
            alt={product.images[1].alt}
            className="absolute inset-0 h-full w-full object-cover opacity-0 transition-opacity duration-500 group-hover:opacity-100"
            loading="lazy"
          />
        )}
        {/* Sale badge */}
        {product.compareAtPrice && (
          <Badge className="absolute top-2 left-2 bg-destructive text-white text-[10px] font-semibold">
            SALE
          </Badge>
        )}
        {/* Wishlist button */}
        <button
          onClick={handleWishlistToggle}
          className="absolute top-2 right-2 p-1.5 rounded-full bg-white/80 backdrop-blur-sm opacity-0 group-hover:opacity-100 transition-opacity hover:bg-white"
          aria-label={wishlisted ? 'Remove from wishlist' : 'Add to wishlist'}
        >
          <Heart
            size={16}
            className={cn(wishlisted ? 'fill-primary text-primary' : 'text-foreground')}
          />
        </button>
      </div>

      {/* Info */}
      <h3 className="font-body text-sm font-medium leading-tight line-clamp-2 mb-1">
        {product.name}
      </h3>
      <PriceDisplay
        price={product.price}
        compareAtPrice={product.compareAtPrice}
        size="sm"
      />
      <Rating
        value={product.avgRating}
        count={product.reviewCount}
        size="sm"
        className="mt-1"
      />
    </Link>
  )
}
