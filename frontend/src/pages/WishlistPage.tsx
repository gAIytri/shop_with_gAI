import { Link } from 'react-router-dom'
import { Heart } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { ProductCard } from '@/components/product/ProductCard'
import { useWishlistStore } from '@/stores/wishlistStore'

export function WishlistPage() {
  const items = useWishlistStore((s) => s.items)

  if (items.length === 0) {
    return (
      <div className="container-page py-20 text-center">
        <Heart size={48} className="mx-auto text-muted-foreground mb-4" />
        <h1 className="font-display text-2xl font-bold mb-2">Your wishlist is empty</h1>
        <p className="text-muted-foreground mb-6">Save items you love for later.</p>
        <Link to="/">
          <Button>Start Shopping</Button>
        </Link>
      </div>
    )
  }

  return (
    <div className="container-page py-8">
      <h1 className="font-display text-2xl font-bold mb-8">
        WISHLIST ({items.length})
      </h1>
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {items.map((product) => (
          <ProductCard key={product.id} product={product} />
        ))}
      </div>
    </div>
  )
}
