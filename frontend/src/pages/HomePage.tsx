import { Link } from 'react-router-dom'
import { ChevronLeft, ChevronRight } from 'lucide-react'
import { useState, useEffect, useCallback } from 'react'
import { Button } from '@/components/ui/button'
import { ProductCard } from '@/components/product/ProductCard'
import { categories, products } from '@/mocks'

const heroSlides = [
  {
    title: 'Curated Comfort',
    subtitle: 'NEW SPRING COLLECTION',
    cta: 'Shop Now',
    href: '/category/furniture',
    image: 'https://placehold.co/1440x600/2D2D5E/FFFFFF?text=Spring+Collection',
  },
  {
    title: 'Illuminate Your Space',
    subtitle: 'ARTISAN LIGHTING',
    cta: 'Explore Lighting',
    href: '/category/lighting',
    image: 'https://placehold.co/1440x600/1B1B3A/FFFFFF?text=Artisan+Lighting',
  },
  {
    title: 'Handcrafted Details',
    subtitle: 'PREMIUM DECOR & ACCENTS',
    cta: 'Discover More',
    href: '/category/decor',
    image: 'https://placehold.co/1440x600/3A3A5E/FFFFFF?text=Premium+Decor',
  },
]

export function HomePage() {
  const [currentSlide, setCurrentSlide] = useState(0)
  const [isPaused, setIsPaused] = useState(false)

  const nextSlide = useCallback(() => {
    setCurrentSlide((prev) => (prev + 1) % heroSlides.length)
  }, [])

  const prevSlide = () => {
    setCurrentSlide((prev) => (prev - 1 + heroSlides.length) % heroSlides.length)
  }

  useEffect(() => {
    if (isPaused) return
    const timer = setInterval(nextSlide, 5000)
    return () => clearInterval(timer)
  }, [isPaused, nextSlide])

  const trendingProducts = products.filter((p) => p.isBestseller).slice(0, 5)
  const newArrivals = products.slice().sort((a, b) => b.createdAt.localeCompare(a.createdAt)).slice(0, 4)

  return (
    <div>
      {/* Hero Carousel */}
      <section
        className="relative overflow-hidden"
        onMouseEnter={() => setIsPaused(true)}
        onMouseLeave={() => setIsPaused(false)}
      >
        <div
          className="flex transition-transform duration-700 ease-in-out"
          style={{ transform: `translateX(-${currentSlide * 100}%)` }}
        >
          {heroSlides.map((slide, i) => (
            <div
              key={i}
              className="w-full flex-shrink-0 relative aspect-[2.4/1] min-h-[400px]"
            >
              <img
                src={slide.image}
                alt={slide.title}
                className="absolute inset-0 h-full w-full object-cover"
              />
              <div className="absolute inset-0 bg-black/30 flex items-center justify-center">
                <div className="text-center text-white">
                  <p className="font-body text-sm tracking-[3px] uppercase mb-3">
                    {slide.subtitle}
                  </p>
                  <h1 className="font-display text-4xl md:text-6xl font-bold mb-6">
                    {slide.title}
                  </h1>
                  <Link to={slide.href}>
                    <Button
                      variant="outline"
                      className="border-white text-white bg-transparent hover:bg-white hover:text-primary text-sm tracking-wider px-8"
                    >
                      {slide.cta}
                    </Button>
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Carousel controls */}
        <button
          onClick={prevSlide}
          className="absolute left-4 top-1/2 -translate-y-1/2 p-2 rounded-full bg-white/20 backdrop-blur-sm text-white hover:bg-white/40 transition"
          aria-label="Previous slide"
        >
          <ChevronLeft size={20} />
        </button>
        <button
          onClick={nextSlide}
          className="absolute right-4 top-1/2 -translate-y-1/2 p-2 rounded-full bg-white/20 backdrop-blur-sm text-white hover:bg-white/40 transition"
          aria-label="Next slide"
        >
          <ChevronRight size={20} />
        </button>

        {/* Dots */}
        <div className="absolute bottom-4 left-1/2 -translate-x-1/2 flex gap-2">
          {heroSlides.map((_, i) => (
            <button
              key={i}
              onClick={() => setCurrentSlide(i)}
              className={`h-2 rounded-full transition-all ${
                i === currentSlide ? 'w-6 bg-white' : 'w-2 bg-white/50'
              }`}
              aria-label={`Go to slide ${i + 1}`}
            />
          ))}
        </div>
      </section>

      {/* Category Grid */}
      <section className="container-page py-16">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {categories.map((cat) => (
            <Link
              key={cat.slug}
              to={`/category/${cat.slug}`}
              className="group relative aspect-[4/3] overflow-hidden"
            >
              <img
                src={cat.imageUrl}
                alt={cat.name}
                className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
                loading="lazy"
              />
              <div className="absolute inset-0 bg-black/20 group-hover:bg-black/30 transition-colors" />
              <div className="absolute bottom-0 left-0 p-4">
                <h3 className="font-body text-xs font-semibold uppercase tracking-[2px] text-white underline underline-offset-4">
                  {cat.name}
                </h3>
              </div>
            </Link>
          ))}
        </div>
      </section>

      {/* Trending Section */}
      <section className="py-16 bg-surface">
        <div className="container-page">
          <h2 className="section-heading mb-8">TRENDING</h2>
          <div className="flex gap-4 overflow-x-auto pb-4 scrollbar-hide lg:grid lg:grid-cols-5 lg:overflow-visible">
            {trendingProducts.map((product) => (
              <div key={product.id} className="w-56 flex-shrink-0 lg:w-auto">
                <ProductCard product={product} />
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Featured Collection Banner */}
      <section className="relative aspect-[3/1] min-h-[300px]">
        <img
          src="https://placehold.co/1440x480/1B1B3A/FFFFFF?text=Featured+Collection"
          alt="Featured Collection"
          className="absolute inset-0 h-full w-full object-cover"
        />
        <div className="absolute inset-0 bg-black/40 flex items-center justify-center">
          <div className="text-center text-white">
            <p className="font-body text-xs tracking-[3px] uppercase mb-2">THE COLLECTION</p>
            <h2 className="font-display text-3xl md:text-5xl font-bold mb-6">Modern Essentials</h2>
            <Link to="/category/furniture">
              <Button
                variant="outline"
                className="border-white text-white bg-transparent hover:bg-white hover:text-primary tracking-wider px-8"
              >
                Shop the Collection
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* New Arrivals */}
      <section className="container-page py-16">
        <h2 className="section-heading mb-8">NEW ARRIVALS</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {newArrivals.map((product) => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>
      </section>
    </div>
  )
}
