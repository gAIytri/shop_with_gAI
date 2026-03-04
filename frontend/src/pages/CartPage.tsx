import { Link } from 'react-router-dom'
import { ShoppingBag } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Separator } from '@/components/ui/separator'
import { QuantityStepper } from '@/components/ui/quantity-stepper'
import { useCartStore } from '@/stores/cartStore'
import { useState } from 'react'

export function CartPage() {
  const { items, couponCode, removeItem, updateQuantity, applyCoupon, removeCoupon, subtotal, shipping, tax, total, discount } = useCartStore()
  const [couponInput, setCouponInput] = useState('')

  const handleApplyCoupon = () => {
    if (couponInput.trim()) {
      applyCoupon(couponInput.trim())
      setCouponInput('')
    }
  }

  if (items.length === 0) {
    return (
      <div className="container-page py-20 text-center">
        <ShoppingBag size={48} className="mx-auto text-muted-foreground mb-4" />
        <h1 className="font-display text-2xl font-bold mb-2">Your cart is empty</h1>
        <p className="text-muted-foreground mb-6">Looks like you haven't added anything yet.</p>
        <Link to="/">
          <Button>Continue Shopping</Button>
        </Link>
      </div>
    )
  }

  const discountAmount = subtotal() * discount

  return (
    <div className="container-page py-8">
      <h1 className="font-display text-2xl font-bold mb-8">
        CART ({items.reduce((sum, i) => sum + i.quantity, 0)})
      </h1>

      <div className="grid grid-cols-1 lg:grid-cols-5 gap-8">
        {/* Cart items — 3 cols */}
        <div className="lg:col-span-3 space-y-6">
          {items.map((item) => (
            <div key={item.id} className="flex gap-4 pb-6 border-b border-border">
              <Link to={`/product/${item.product.slug}`} className="w-24 h-24 flex-shrink-0 bg-surface">
                <img
                  src={item.product.images[0]?.url}
                  alt={item.product.name}
                  className="h-full w-full object-cover"
                />
              </Link>
              <div className="flex-1 min-w-0">
                <div className="flex justify-between gap-2">
                  <Link to={`/product/${item.product.slug}`} className="font-medium text-sm hover:underline line-clamp-1">
                    {item.product.name}
                  </Link>
                  <span className="font-semibold text-sm whitespace-nowrap">
                    ${(item.product.price * item.quantity).toFixed(2)}
                  </span>
                </div>
                <div className="text-xs text-muted-foreground mt-1 space-y-0.5">
                  <p>Color: {item.selectedColor}</p>
                  {item.selectedSize && <p>Size: {item.selectedSize}</p>}
                </div>
                <div className="flex items-center justify-between mt-3">
                  <QuantityStepper
                    value={item.quantity}
                    onChange={(val) => updateQuantity(item.id, val)}
                    className="scale-90 origin-left"
                  />
                  <button
                    onClick={() => removeItem(item.id)}
                    className="text-xs text-muted-foreground underline hover:text-foreground transition-colors"
                  >
                    Remove
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Order summary — 2 cols */}
        <div className="lg:col-span-2">
          <div className="border border-border p-6">
            <h2 className="font-body text-sm font-semibold uppercase tracking-wider mb-4">
              ORDER SUMMARY
            </h2>

            <div className="space-y-3 text-sm">
              <div className="flex justify-between">
                <span>Subtotal</span>
                <span className="font-medium">${subtotal().toFixed(2)}</span>
              </div>
              <div className="flex justify-between">
                <span>Shipping</span>
                <span className="font-medium">
                  {shipping() === 0 ? 'Free' : `$${shipping().toFixed(2)}`}
                </span>
              </div>
              <div className="flex justify-between">
                <span>Tax</span>
                <span className="font-medium">${tax().toFixed(2)}</span>
              </div>
              {discountAmount > 0 && (
                <div className="flex justify-between text-success">
                  <span>Discount ({couponCode})</span>
                  <span>-${discountAmount.toFixed(2)}</span>
                </div>
              )}
            </div>

            <Separator className="my-4" />

            {/* Coupon */}
            {couponCode ? (
              <div className="flex items-center justify-between text-sm mb-4">
                <span className="text-success">Code: {couponCode}</span>
                <button onClick={removeCoupon} className="text-xs underline text-muted-foreground">
                  Remove
                </button>
              </div>
            ) : (
              <div className="flex gap-2 mb-4">
                <Input
                  value={couponInput}
                  onChange={(e) => setCouponInput(e.target.value)}
                  placeholder="Discount Code"
                  className="text-sm"
                  onKeyDown={(e) => e.key === 'Enter' && handleApplyCoupon()}
                />
                <Button variant="outline" size="sm" onClick={handleApplyCoupon} className="shrink-0">
                  APPLY
                </Button>
              </div>
            )}

            <div className="flex justify-between text-lg font-bold mb-6">
              <span>TOTAL:</span>
              <span>${total().toFixed(2)}</span>
            </div>

            <Link to="/checkout">
              <Button className="w-full h-12 text-sm tracking-wider uppercase">
                CHECKOUT
              </Button>
            </Link>

            {/* Payment icons */}
            <div className="flex items-center justify-center gap-3 mt-4 text-xs text-muted-foreground">
              <span className="border border-border px-2 py-1 rounded text-[10px]">Apple Pay</span>
              <span className="border border-border px-2 py-1 rounded text-[10px]">PayPal</span>
              <span className="border border-border px-2 py-1 rounded text-[10px]">Google Pay</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
