import { Link } from 'react-router-dom'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'

const footerLinks = {
  Shop: [
    { label: 'Lighting', href: '/category/lighting' },
    { label: 'Decor', href: '/category/decor' },
    { label: 'Art & Mirrors', href: '/category/art' },
    { label: 'Bedding', href: '/category/bedding' },
    { label: 'Furniture', href: '/category/furniture' },
    { label: 'Rugs', href: '/category/rugs' },
  ],
  About: [
    { label: 'Our Story', href: '/about' },
    { label: 'Sustainability', href: '/sustainability' },
    { label: 'Careers', href: '/careers' },
    { label: 'Press', href: '/press' },
  ],
  Help: [
    { label: 'Contact Us', href: '/contact' },
    { label: 'Shipping & Returns', href: '/shipping-returns' },
    { label: 'FAQ', href: '/faq' },
    { label: 'Track Order', href: '/account/orders' },
  ],
  Legal: [
    { label: 'Privacy Policy', href: '/privacy' },
    { label: 'Terms of Service', href: '/terms' },
    { label: 'Cookie Policy', href: '/cookies' },
  ],
}

export function Footer() {
  return (
    <footer className="bg-primary text-primary-foreground">
      {/* Newsletter bar */}
      <div className="border-b border-white/10">
        <div className="container-page flex flex-col sm:flex-row items-center justify-between gap-4 py-8">
          <div>
            <h3 className="font-display text-lg font-semibold">SIGN UP FOR OUR NEWSLETTER</h3>
            <p className="text-sm text-white/60 mt-1">
              Exclusive offers, new arrivals, and design inspiration
            </p>
          </div>
          <div className="flex w-full sm:w-auto gap-2">
            <Input
              type="email"
              placeholder="Email address"
              className="bg-white/10 border-white/20 text-white placeholder:text-white/40 w-full sm:w-64"
            />
            <Button variant="outline" className="border-white text-white hover:bg-white hover:text-primary shrink-0">
              SUBSCRIBE
            </Button>
          </div>
        </div>
      </div>

      {/* Link columns */}
      <div className="container-page py-12">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
          {Object.entries(footerLinks).map(([title, links]) => (
            <div key={title}>
              <h4 className="font-body text-xs font-semibold uppercase tracking-widest mb-4">
                {title}
              </h4>
              <ul className="space-y-2">
                {links.map((link) => (
                  <li key={link.label}>
                    <Link
                      to={link.href}
                      className="text-sm text-white/60 hover:text-white transition-colors"
                    >
                      {link.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </div>

      {/* Copyright */}
      <div className="border-t border-white/10">
        <div className="container-page py-6 text-center text-xs text-white/40">
          &copy; {new Date().getFullYear()} Shop with gAI. All rights reserved.
        </div>
      </div>
    </footer>
  )
}
