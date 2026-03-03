import { Link } from 'react-router-dom'
import { Badge } from '@/components/ui/badge'
import { mockOrders } from '@/mocks'
import { cn } from '@/lib/utils'

const statusColors: Record<string, string> = {
  pending: 'bg-yellow-100 text-yellow-800',
  confirmed: 'bg-blue-100 text-blue-800',
  processing: 'bg-blue-100 text-blue-800',
  shipped: 'bg-purple-100 text-purple-800',
  delivered: 'bg-green-100 text-green-800',
  cancelled: 'bg-red-100 text-red-800',
  returned: 'bg-gray-100 text-gray-800',
}

export function OrdersPage() {
  return (
    <div>
      <h2 className="font-display text-lg font-semibold mb-6">Order History</h2>
      <div className="space-y-4">
        {mockOrders.map((order) => (
          <Link
            key={order.id}
            to={`/account/orders/${order.orderNumber}`}
            className="block border border-border p-4 hover:border-primary/30 transition-colors"
          >
            <div className="flex flex-wrap items-center justify-between gap-2 mb-2">
              <span className="font-medium text-sm">{order.orderNumber}</span>
              <Badge className={cn('text-[10px] font-semibold', statusColors[order.status])}>
                {order.status.toUpperCase()}
              </Badge>
            </div>
            <div className="flex flex-wrap items-center justify-between gap-2 text-sm text-muted-foreground">
              <span>
                {new Date(order.createdAt).toLocaleDateString('en-US', {
                  year: 'numeric',
                  month: 'long',
                  day: 'numeric',
                })}
              </span>
              <span className="font-medium text-foreground">${order.total.toFixed(2)}</span>
            </div>
            <div className="flex gap-2 mt-3">
              {order.items.map((item) => (
                <div key={item.id} className="w-12 h-12 bg-surface flex-shrink-0">
                  <img src={item.productImage} alt={item.productName} className="h-full w-full object-cover" />
                </div>
              ))}
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}
