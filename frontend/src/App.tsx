import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { Toaster } from '@/components/ui/sonner'
import { ErrorBoundary } from '@/components/ErrorBoundary'
import { PageLayout } from '@/components/layout/PageLayout'
import { HomePage } from '@/pages/HomePage'
import { CollectionPage } from '@/pages/CollectionPage'
import { ProductDetailPage } from '@/pages/ProductDetailPage'
import { CartPage } from '@/pages/CartPage'
import { CheckoutPage } from '@/pages/CheckoutPage'
import { OrderConfirmationPage } from '@/pages/OrderConfirmationPage'
import { WishlistPage } from '@/pages/WishlistPage'
import { AccountLayout } from '@/pages/AccountPage'
import { ProfilePage } from '@/pages/account/ProfilePage'
import { AddressesPage } from '@/pages/account/AddressesPage'
import { OrdersPage } from '@/pages/account/OrdersPage'
import { OrderDetailPage } from '@/pages/account/OrderDetailPage'

function App() {
  return (
    <ErrorBoundary>
      <BrowserRouter>
        <Routes>
          <Route element={<PageLayout />}>
            <Route path="/" element={<HomePage />} />
            <Route path="/category/:slug" element={<CollectionPage />} />
            <Route path="/product/:slug" element={<ProductDetailPage />} />
            <Route path="/cart" element={<CartPage />} />
            <Route path="/checkout" element={<CheckoutPage />} />
            <Route path="/order-confirmation/:orderNumber" element={<OrderConfirmationPage />} />
            <Route path="/wishlist" element={<WishlistPage />} />
            <Route path="/account" element={<AccountLayout />}>
              <Route index element={<ProfilePage />} />
              <Route path="addresses" element={<AddressesPage />} />
              <Route path="orders" element={<OrdersPage />} />
              <Route path="orders/:orderNumber" element={<OrderDetailPage />} />
            </Route>
          </Route>
        </Routes>
        <Toaster position="bottom-right" />
      </BrowserRouter>
    </ErrorBoundary>
  )
}

export default App
