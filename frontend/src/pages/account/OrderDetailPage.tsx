import { useParams, Link } from 'react-router-dom'
import { Badge } from '@/components/ui/badge'
import { Breadcrumbs } from '@/components/ui/breadcrumbs'
import { Separator } from '@/components/ui/separator'
import { mockOrders } from '@/mocks'
import { cn } from '@/lib/utils'

const statusSteps = ['pending', 'confirmed', 'processing', 'shipped', 'delivered']

const statusColors: Record<string, string> = {
  pending: 'bg-yellow-100 text-yellow-800',
  confirmed: 'bg-blue-100 text-blue-800',
  processing: 'bg-blue-100 text-blue-800',
  shipped: 'bg-purple-100 text-purple-800',
  delivered: 'bg-green-100 text-green-800',
  cancelled: 'bg-red-100 text-red-800',
  returned: 'bg-gray-100 text-gray-800',
}

export function OrderDetailPage() {
  const { orderNumber } = useParams<{ orderNumber: string }>()
  const order = mockOrders.find((o) => o.orderNumber === orderNumber)

  if (!order) {
    return (
      <div className="py-10 text-center">
        <p className="text-muted-foreground">Order not found.</p>
        <Link to="/account/orders" className="text-sm underline mt-2 inline-block">
          Back to orders
        </Link>
      </div>
    )
  }

  const currentStepIndex = statusSteps.indexOf(order.status)

  return (
    <div>
      <Breadcrumbs
        items={[
          { label: 'Orders', href: '/account/orders' },
          { label: order.orderNumber },
        ]}
        className="mb-6"
      />

      <div className="flex flex-wrap items-center gap-3 mb-6">
        <h2 className="font-display text-lg font-semibold">{order.orderNumber}</h2>
        <Badge className={cn('text-[10px]', statusColors[order.status])}>
          {order.status.toUpperCase()}
        </Badge>
      </div>

      {/* Status timeline */}
      {!['cancelled', 'returned'].includes(order.status) && (
        <div className="flex items-center gap-1 mb-8 overflow-x-auto">
          {statusSteps.map((step, i) => (
            <div key={step} className="flex items-center gap-1">
              <div
                className={cn(
                  'w-3 h-3 rounded-full flex-shrink-0',
                  i <= currentStepIndex ? 'bg-primary' : 'bg-border'
                )}
              />
              <span className={cn('text-[10px] uppercase tracking-wide whitespace-nowrap', i <= currentStepIndex ? 'text-foreground' : 'text-muted-foreground')}>
                {step}
              </span>
              {i < statusSteps.length - 1 && (
                <div className={cn('w-8 h-0.5 flex-shrink-0', i < currentStepIndex ? 'bg-primary' : 'bg-border')} />
              )}
            </div>
          ))}
        </div>
      )}

      {/* Items */}
      <h3 className="font-medium text-sm mb-3">Items</h3>
      <div className="space-y-3 mb-6">
        {order.items.map((item) => (
          <div key={item.id} className="flex gap-3">
            <div className="w-16 h-16 bg-surface flex-shrink-0">
              <img src={item.productImage} alt={item.productName} className="h-full w-full object-cover" />
            </div>
            <div className="flex-1 text-sm">
              <p className="font-medium">{item.productName}</p>
              <p className="text-xs text-muted-foreground">
                {item.selectedColor}
                {item.selectedSize && ` · ${item.selectedSize}`}
                {' · '}Qty {item.quantity}
              </p>
            </div>
            <span className="text-sm font-medium">${(item.unitPrice * item.quantity).toFixed(2)}</span>
          </div>
        ))}
      </div>

      <Separator className="mb-6" />

      {/* Summary */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
        <div>
          <h3 className="font-medium text-sm mb-2">Shipping Address</h3>
          <p className="text-sm text-muted-foreground">
            {order.shippingAddress.firstName} {order.shippingAddress.lastName}<br />
            {order.shippingAddress.street1}<br />
            {order.shippingAddress.street2 && <>{order.shippingAddress.street2}<br /></>}
            {order.shippingAddress.city}, {order.shippingAddress.state} {order.shippingAddress.zipCode}
          </p>
        </div>
        <div>
          <h3 className="font-medium text-sm mb-2">Order Summary</h3>
          <div className="space-y-1 text-sm">
            <div className="flex justify-between">
              <span className="text-muted-foreground">Subtotal</span>
              <span>${order.subtotal.toFixed(2)}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Shipping</span>
              <span>{order.shipping === 0 ? 'Free' : `$${order.shipping.toFixed(2)}`}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Tax</span>
              <span>${order.tax.toFixed(2)}</span>
            </div>
            {order.discount > 0 && (
              <div className="flex justify-between text-success">
                <span>Discount</span>
                <span>-${order.discount.toFixed(2)}</span>
              </div>
            )}
            <Separator className="my-2" />
            <div className="flex justify-between font-bold">
              <span>Total</span>
              <span>${order.total.toFixed(2)}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
