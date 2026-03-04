import { Outlet } from 'react-router-dom'
import { Header } from './Header'
import { Footer } from './Footer'
import { PromoBar } from '@/components/ui/promo-bar'

export function PageLayout() {
  return (
    <div className="flex min-h-screen flex-col">
      <PromoBar message="FREE SHIPPING ON ORDERS OVER $100" />
      <Header />
      <main className="flex-1">
        <Outlet />
      </main>
      <Footer />
    </div>
  )
}
