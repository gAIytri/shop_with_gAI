import { Link } from 'react-router-dom'
import { Search, User, ShoppingBag, Menu, Heart } from 'lucide-react'
import { Sheet, SheetContent, SheetTrigger, SheetTitle } from '@/components/ui/sheet'
import { categories } from '@/mocks'
import { useCartStore } from '@/stores/cartStore'
import { useUIStore } from '@/stores/uiStore'

export function Header() {
  const itemCount = useCartStore((s) => s.itemCount())
  const { isMobileMenuOpen, setMobileMenuOpen } = useUIStore()

  return (
    <header className="sticky top-0 z-50 bg-background border-b border-border">
      <div className="container-page flex h-16 items-center justify-between">
        {/* Mobile menu trigger */}
        <Sheet open={isMobileMenuOpen} onOpenChange={setMobileMenuOpen}>
          <SheetTrigger asChild>
            <button className="lg:hidden p-2 -ml-2" aria-label="Open menu">
              <Menu size={20} />
            </button>
          </SheetTrigger>
          <SheetContent side="left" className="w-[300px] p-0">
            <SheetTitle className="sr-only">Navigation menu</SheetTitle>
            <nav className="flex flex-col pt-8">
              {categories.map((cat) => (
                <Link
                  key={cat.slug}
                  to={`/category/${cat.slug}`}
                  className="nav-link px-6 py-3 border-b border-border"
                  onClick={() => setMobileMenuOpen(false)}
                >
                  {cat.name}
                </Link>
              ))}
            </nav>
          </SheetContent>
        </Sheet>

        {/* Logo */}
        <Link to="/" className="font-display text-xl font-bold tracking-wide text-primary">
          SHOP WITH <span className="italic font-normal">gAI</span>
        </Link>

        {/* Desktop navigation */}
        <nav className="hidden lg:flex items-center gap-8">
          {categories.map((cat) => (
            <Link key={cat.slug} to={`/category/${cat.slug}`} className="nav-link">
              {cat.name}
            </Link>
          ))}
        </nav>

        {/* Right icons */}
        <div className="flex items-center gap-1">
          <Link to="/search" className="p-2 hover:text-muted-foreground transition-colors" aria-label="Search">
            <Search size={20} />
          </Link>
          <Link to="/wishlist" className="hidden sm:block p-2 hover:text-muted-foreground transition-colors" aria-label="Wishlist">
            <Heart size={20} />
          </Link>
          <Link to="/account" className="hidden sm:block p-2 hover:text-muted-foreground transition-colors" aria-label="Account">
            <User size={20} />
          </Link>
          <Link to="/cart" className="relative p-2 hover:text-muted-foreground transition-colors" aria-label="Cart">
            <ShoppingBag size={20} />
            {itemCount > 0 && (
              <span className="absolute -top-0.5 -right-0.5 flex h-4 w-4 items-center justify-center rounded-full bg-primary text-[10px] font-bold text-primary-foreground">
                {itemCount > 9 ? '9+' : itemCount}
              </span>
            )}
          </Link>
        </div>
      </div>
    </header>
  )
}
