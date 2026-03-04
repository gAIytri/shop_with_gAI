import { useParams } from 'react-router-dom'
import { useState } from 'react'
import { toast } from 'sonner'
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion'
import { Button } from '@/components/ui/button'
import { Breadcrumbs } from '@/components/ui/breadcrumbs'
import { Rating } from '@/components/ui/rating'
import { PriceDisplay } from '@/components/ui/price-display'
import { QuantityStepper } from '@/components/ui/quantity-stepper'
import { ProductCard } from '@/components/product/ProductCard'
import { products, mockReviews } from '@/mocks'
import { useCartStore } from '@/stores/cartStore'
import { cn } from '@/lib/utils'

export function ProductDetailPage() {
  const { slug } = useParams<{ slug: string }>()
  const product = products.find((p) => p.slug === slug)
  const addItem = useCartStore((s) => s.addItem)

  const [selectedImage, setSelectedImage] = useState(0)
  const [selectedColor, setSelectedColor] = useState<string>('')
  const [quantity, setQuantity] = useState(1)

  if (!product) {
    return (
      <div className="container-page py-20 text-center">
        <h1 className="text-2xl font-display">Product not found</h1>
      </div>
    )
  }

  const colors = product.attributes.color
  const activeColor = selectedColor || colors[0] || ''
  const productReviews = mockReviews.filter((r) => r.productId === product.id)
  const relatedProducts = products
    .filter((p) => p.categorySlug === product.categorySlug && p.id !== product.id)
    .slice(0, 4)

  const handleAddToCart = () => {
    addItem(product, activeColor)
    toast.success(`${product.name} added to cart`)
  }

  return (
    <div className="container-page py-6">
      <Breadcrumbs
        items={[
          { label: 'Home', href: '/' },
          { label: product.categoryName, href: `/category/${product.categorySlug}` },
          { label: product.name },
        ]}
        className="mb-6"
      />

      {/* Top section: Images + Info */}
      <div className="grid grid-cols-1 lg:grid-cols-5 gap-8 mb-12">
        {/* Images — 3 cols */}
        <div className="lg:col-span-3">
          <div className="aspect-square overflow-hidden bg-surface mb-3">
            <img
              src={product.images[selectedImage]?.url}
              alt={product.images[selectedImage]?.alt || product.name}
              className="h-full w-full object-cover"
            />
          </div>
          <div className="flex gap-2 overflow-x-auto">
            {product.images.map((img, i) => (
              <button
                key={img.id}
                onClick={() => setSelectedImage(i)}
                className={cn(
                  'w-16 h-16 flex-shrink-0 overflow-hidden border-2 transition-colors',
                  i === selectedImage ? 'border-primary' : 'border-transparent'
                )}
              >
                <img src={img.url} alt={img.alt} className="h-full w-full object-cover" />
              </button>
            ))}
          </div>
        </div>

        {/* Info — 2 cols */}
        <div className="lg:col-span-2">
          <h1 className="font-display text-2xl md:text-3xl font-bold mb-2">{product.name}</h1>

          <div className="flex items-center gap-4 mb-4">
            <PriceDisplay
              price={product.price}
              compareAtPrice={product.compareAtPrice}
              size="lg"
            />
            <Rating value={product.avgRating} count={product.reviewCount} size="md" />
          </div>

          {/* Color selector */}
          {colors.length > 0 && (
            <div className="mb-6">
              <p className="text-sm font-medium mb-2">
                SELECT COLOR: <span className="font-normal">{activeColor}</span>
              </p>
              <div className="flex gap-2">
                {colors.map((color) => (
                  <button
                    key={color}
                    onClick={() => setSelectedColor(color)}
                    className={cn(
                      'px-4 py-2 text-sm border transition-colors',
                      activeColor === color
                        ? 'border-primary bg-primary text-primary-foreground'
                        : 'border-border hover:border-foreground'
                    )}
                  >
                    {color}
                  </button>
                ))}
              </div>
            </div>
          )}

          {/* Installment info */}
          <p className="text-sm text-muted-foreground mb-6">
            Pay in 2 interest-free installments of{' '}
            <strong>${(product.price / 2).toFixed(2)}</strong> with Shop Pay
          </p>

          {/* Quantity + Add to bag */}
          <div className="flex items-center gap-4 mb-6">
            <QuantityStepper value={quantity} onChange={setQuantity} />
            <Button
              onClick={handleAddToCart}
              className="flex-1 h-12 text-sm tracking-wider uppercase"
              size="lg"
            >
              ADD TO BAG
            </Button>
          </div>

          {/* Short description */}
          <p className="text-sm text-muted-foreground leading-relaxed">
            {product.enrichedDescription.short}
          </p>
        </div>
      </div>

      {/* Accordion sections */}
      <Accordion type="multiple" defaultValue={['description']} className="mb-12">
        <AccordionItem value="description">
          <AccordionTrigger className="text-sm font-semibold uppercase tracking-wider">
            Description
          </AccordionTrigger>
          <AccordionContent>
            <p className="text-sm leading-relaxed text-muted-foreground mb-4">
              {product.enrichedDescription.long}
            </p>
            <ul className="list-disc list-inside space-y-1 text-sm text-muted-foreground">
              {product.enrichedDescription.features.map((f, i) => (
                <li key={i}>{f}</li>
              ))}
            </ul>
          </AccordionContent>
        </AccordionItem>
        <AccordionItem value="shipping">
          <AccordionTrigger className="text-sm font-semibold uppercase tracking-wider">
            Shipping & Returns
          </AccordionTrigger>
          <AccordionContent>
            <div className="text-sm text-muted-foreground space-y-2">
              <p>Free standard shipping on orders over $100.</p>
              <p>Standard shipping: 5-7 business days. Express: 2-3 business days ($14.99).</p>
              <p>Returns accepted within 30 days of delivery. Items must be unused and in original packaging.</p>
            </div>
          </AccordionContent>
        </AccordionItem>
        <AccordionItem value="details">
          <AccordionTrigger className="text-sm font-semibold uppercase tracking-wider">
            Details & Dimensions
          </AccordionTrigger>
          <AccordionContent>
            <div className="text-sm text-muted-foreground space-y-1">
              {Object.entries(product.attributes).map(([key, values]) => (
                <p key={key}>
                  <span className="font-medium capitalize">{key}:</span>{' '}
                  {values.join(', ')}
                </p>
              ))}
              <p className="mt-2">
                <span className="font-medium">Care:</span>{' '}
                {product.enrichedDescription.careInstructions}
              </p>
            </div>
          </AccordionContent>
        </AccordionItem>
      </Accordion>

      {/* Reviews section */}
      {productReviews.length > 0 && (
        <section className="mb-12">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="font-display text-xl font-semibold">Customer Reviews</h2>
              <div className="flex items-center gap-2 mt-1">
                <Rating value={product.avgRating} size="md" />
                <span className="text-sm text-muted-foreground">
                  {product.avgRating}/5 ({product.reviewCount} reviews)
                </span>
              </div>
            </div>
            <Button variant="outline" size="sm">Write a Review</Button>
          </div>
          <div className="space-y-6">
            {productReviews.map((review) => (
              <div key={review.id} className="border-b border-border pb-6">
                <Rating value={review.rating} size="sm" />
                <h4 className="font-medium mt-1">{review.title}</h4>
                <p className="text-sm text-muted-foreground mt-1">{review.body}</p>
                <p className="text-xs text-muted-foreground mt-2">
                  {review.userName}
                  {review.isVerifiedPurchase && (
                    <span className="ml-2 text-success">Verified purchase</span>
                  )}
                  {' · '}
                  {new Date(review.createdAt).toLocaleDateString('en-US', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric',
                  })}
                </p>
              </div>
            ))}
          </div>
        </section>
      )}

      {/* Related products */}
      {relatedProducts.length > 0 && (
        <section className="mb-12">
          <h2 className="section-heading mb-8">YOU MAY ALSO LIKE</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {relatedProducts.map((p) => (
              <ProductCard key={p.id} product={p} />
            ))}
          </div>
        </section>
      )}
    </div>
  )
}
