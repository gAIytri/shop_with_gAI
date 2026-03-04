import { Link, Outlet, useLocation } from 'react-router-dom'
import { User, MapPin, Package } from 'lucide-react'
import { cn } from '@/lib/utils'

const accountNav = [
  { label: 'Profile', href: '/account', icon: User },
  { label: 'Addresses', href: '/account/addresses', icon: MapPin },
  { label: 'Orders', href: '/account/orders', icon: Package },
]

export function AccountLayout() {
  const location = useLocation()

  return (
    <div className="container-page py-8">
      <h1 className="font-display text-2xl font-bold mb-8">MY ACCOUNT</h1>
      <div className="flex flex-col md:flex-row gap-8">
        <nav className="flex md:flex-col gap-2 md:w-48 flex-shrink-0">
          {accountNav.map((item) => {
            const Icon = item.icon
            const isActive = location.pathname === item.href
            return (
              <Link
                key={item.href}
                to={item.href}
                className={cn(
                  'flex items-center gap-2 px-4 py-2 text-sm rounded transition-colors',
                  isActive ? 'bg-primary text-primary-foreground' : 'text-muted-foreground hover:text-foreground hover:bg-secondary'
                )}
              >
                <Icon size={16} />
                {item.label}
              </Link>
            )
          })}
        </nav>
        <div className="flex-1">
          <Outlet />
        </div>
      </div>
    </div>
  )
}
