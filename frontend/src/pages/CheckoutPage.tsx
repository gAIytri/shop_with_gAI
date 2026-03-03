import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Separator } from '@/components/ui/separator'
import { useCartStore } from '@/stores/cartStore'
import { cn } from '@/lib/utils'

const steps = ['Shipping', 'Payment', 'Review']

const shippingMethods = [
  { id: 'standard', label: 'Standard Shipping', description: '5-7 business days', price: 0 },
  { id: 'express', label: 'Express Shipping', description: '2-3 business days', price: 14.99 },
]

export function CheckoutPage() {
  const navigate = useNavigate()
  const { items, subtotal, tax, total, clearCart } = useCartStore()
  const [currentStep, setCurrentStep] = useState(0)
  const [selectedShipping, setSelectedShipping] = useState('standard')

  const handlePlaceOrder = () => {
    clearCart()
    navigate('/order-confirmation/ORD-2026-00099')
  }

  if (items.length === 0) {
    navigate('/cart')
    return null
  }

  return (
    <div className="container-page py-8">
      {/* Progress */}
      <div className="flex items-center justify-center gap-4 mb-10">
        {steps.map((step, i) => (
          <div key={step} className="flex items-center gap-2">
            <div
              className={cn(
                'w-8 h-8 rounded-full flex items-center justify-center text-sm font-semibold border-2',
                i <= currentStep
                  ? 'bg-primary text-primary-foreground border-primary'
                  : 'border-border text-muted-foreground'
              )}
            >
              {i + 1}
            </div>
            <span className={cn('text-sm font-medium hidden sm:block', i > currentStep && 'text-muted-foreground')}>
              {step}
            </span>
            {i < steps.length - 1 && <div className="w-12 h-px bg-border hidden sm:block" />}
          </div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-5 gap-8">
        {/* Form area — 3 cols */}
        <div className="lg:col-span-3">
          {/* Step 1: Shipping */}
          {currentStep === 0 && (
            <div>
              <h2 className="font-display text-xl font-semibold mb-6">Shipping Address</h2>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="firstName">First Name</Label>
                  <Input id="firstName" defaultValue="Sarah" className="mt-1" />
                </div>
                <div>
                  <Label htmlFor="lastName">Last Name</Label>
                  <Input id="lastName" defaultValue="Johnson" className="mt-1" />
                </div>
                <div className="col-span-2">
                  <Label htmlFor="street">Street Address</Label>
                  <Input id="street" defaultValue="742 Evergreen Terrace" className="mt-1" />
                </div>
                <div>
                  <Label htmlFor="city">City</Label>
                  <Input id="city" defaultValue="Portland" className="mt-1" />
                </div>
                <div>
                  <Label htmlFor="state">State</Label>
                  <Input id="state" defaultValue="OR" className="mt-1" />
                </div>
                <div>
                  <Label htmlFor="zip">ZIP Code</Label>
                  <Input id="zip" defaultValue="97201" className="mt-1" />
                </div>
                <div>
                  <Label htmlFor="phone">Phone</Label>
                  <Input id="phone" defaultValue="(555) 123-4567" className="mt-1" />
                </div>
              </div>

              <h3 className="font-display text-lg font-semibold mt-8 mb-4">Shipping Method</h3>
              <div className="space-y-3">
                {shippingMethods.map((method) => (
                  <label
                    key={method.id}
                    className={cn(
                      'flex items-center justify-between p-4 border cursor-pointer transition-colors',
                      selectedShipping === method.id ? 'border-primary' : 'border-border'
                    )}
                  >
                    <div className="flex items-center gap-3">
                      <input
                        type="radio"
                        name="shipping"
                        value={method.id}
                        checked={selectedShipping === method.id}
                        onChange={() => setSelectedShipping(method.id)}
                        className="accent-primary"
                      />
                      <div>
                        <p className="text-sm font-medium">{method.label}</p>
                        <p className="text-xs text-muted-foreground">{method.description}</p>
                      </div>
                    </div>
                    <span className="text-sm font-medium">
                      {method.price === 0 ? 'Free' : `$${method.price.toFixed(2)}`}
                    </span>
                  </label>
                ))}
              </div>

              <Button className="mt-8 w-full h-12" onClick={() => setCurrentStep(1)}>
                Continue to Payment
              </Button>
            </div>
          )}

          {/* Step 2: Payment */}
          {currentStep === 1 && (
            <div>
              <h2 className="font-display text-xl font-semibold mb-6">Payment</h2>
              <div className="border border-border p-8 text-center">
                <p className="text-muted-foreground text-sm">
                  Stripe Elements will be integrated here in WS-6.
                </p>
                <div className="mt-4 space-y-4">
                  <div>
                    <Label htmlFor="cardNumber">Card Number</Label>
                    <Input id="cardNumber" placeholder="4242 4242 4242 4242" className="mt-1" />
                  </div>
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <Label htmlFor="expiry">Expiry</Label>
                      <Input id="expiry" placeholder="MM / YY" className="mt-1" />
                    </div>
                    <div>
                      <Label htmlFor="cvc">CVC</Label>
                      <Input id="cvc" placeholder="123" className="mt-1" />
                    </div>
                  </div>
                </div>
              </div>
              <div className="flex gap-4 mt-8">
                <Button variant="outline" className="flex-1 h-12" onClick={() => setCurrentStep(0)}>
                  Back
                </Button>
                <Button className="flex-1 h-12" onClick={() => setCurrentStep(2)}>
                  Review Order
                </Button>
              </div>
            </div>
          )}

          {/* Step 3: Review */}
          {currentStep === 2 && (
            <div>
              <h2 className="font-display text-xl font-semibold mb-6">Review Your Order</h2>
              <div className="space-y-4">
                {items.map((item) => (
                  <div key={item.id} className="flex gap-3 text-sm">
                    <div className="w-16 h-16 bg-surface flex-shrink-0">
                      <img src={item.product.images[0]?.url} alt={item.product.name} className="h-full w-full object-cover" />
                    </div>
                    <div className="flex-1">
                      <p className="font-medium">{item.product.name}</p>
                      <p className="text-xs text-muted-foreground">{item.selectedColor} · Qty {item.quantity}</p>
                    </div>
                    <p className="font-medium">${(item.product.price * item.quantity).toFixed(2)}</p>
                  </div>
                ))}
              </div>
              <div className="flex gap-4 mt-8">
                <Button variant="outline" className="flex-1 h-12" onClick={() => setCurrentStep(1)}>
                  Back
                </Button>
                <Button className="flex-1 h-12" onClick={handlePlaceOrder}>
                  Place Order
                </Button>
              </div>
            </div>
          )}
        </div>

        {/* Order summary sidebar — 2 cols */}
        <div className="lg:col-span-2">
          <div className="border border-border p-6 lg:sticky lg:top-24">
            <h3 className="font-body text-sm font-semibold uppercase tracking-wider mb-4">
              Order Summary
            </h3>
            <div className="space-y-2 text-sm">
              {items.map((item) => (
                <div key={item.id} className="flex justify-between">
                  <span className="text-muted-foreground truncate mr-2">
                    {item.product.name} x{item.quantity}
                  </span>
                  <span>${(item.product.price * item.quantity).toFixed(2)}</span>
                </div>
              ))}
            </div>
            <Separator className="my-4" />
            <div className="space-y-2 text-sm">
              <div className="flex justify-between">
                <span>Subtotal</span>
                <span>${subtotal().toFixed(2)}</span>
              </div>
              <div className="flex justify-between">
                <span>Shipping</span>
                <span>{selectedShipping === 'standard' ? 'Free' : '$14.99'}</span>
              </div>
              <div className="flex justify-between">
                <span>Tax</span>
                <span>${tax().toFixed(2)}</span>
              </div>
            </div>
            <Separator className="my-4" />
            <div className="flex justify-between font-bold">
              <span>Total</span>
              <span>${total().toFixed(2)}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
