import { Link, useParams } from 'react-router-dom'
import { CheckCircle } from 'lucide-react'
import { Button } from '@/components/ui/button'

export function OrderConfirmationPage() {
  const { orderNumber } = useParams<{ orderNumber: string }>()

  return (
    <div className="container-page py-20 text-center max-w-lg mx-auto">
      <CheckCircle size={64} className="mx-auto text-success mb-6" />
      <h1 className="font-display text-3xl font-bold mb-2">Thank you for your order!</h1>
      <p className="text-muted-foreground mb-2">
        Your order has been placed successfully.
      </p>
      <p className="text-lg font-semibold mb-8">
        Order Number: {orderNumber || 'ORD-2026-00099'}
      </p>
      <p className="text-sm text-muted-foreground mb-8">
        We&apos;ll send you a confirmation email with tracking details once your order ships.
      </p>
      <div className="flex flex-col sm:flex-row gap-3 justify-center">
        <Link to="/">
          <Button variant="outline" className="w-full sm:w-auto">Continue Shopping</Button>
        </Link>
        <Link to="/account/orders">
          <Button className="w-full sm:w-auto">Track Order</Button>
        </Link>
      </div>
    </div>
  )
}
