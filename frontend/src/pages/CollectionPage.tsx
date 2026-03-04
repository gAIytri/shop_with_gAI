import { useParams } from 'react-router-dom'
import { useMemo } from 'react'
import { SlidersHorizontal, X } from 'lucide-react'
import { Sheet, SheetContent, SheetTrigger, SheetTitle } from '@/components/ui/sheet'
import { Button } from '@/components/ui/button'
import { Breadcrumbs } from '@/components/ui/breadcrumbs'
import { ProductCard } from '@/components/product/ProductCard'
import { FilterSidebar } from '@/components/product/FilterSidebar'
import { categories, products } from '@/mocks'
import { useFilterStore } from '@/stores/filterStore'
import type { SortOption } from '@/types'

const sortOptions: { value: SortOption; label: string }[] = [
  { value: 'best-selling', label: 'Best Selling' },
  { value: 'price-asc', label: 'Price: Low to High' },
  { value: 'price-desc', label: 'Price: High to Low' },
  { value: 'newest', label: 'Newest' },
  { value: 'top-rated', label: 'Top Rated' },
]

export function CollectionPage() {
  const { slug } = useParams<{ slug: string }>()
  const category = categories.find((c) => c.slug === slug)
  const filters = useFilterStore()

  const filteredProducts = useMemo(() => {
    let result = products.filter((p) => p.categorySlug === slug)

    if (filters.colors.length > 0) {
      result = result.filter((p) =>
        p.attributes.color.some((c) => filters.colors.includes(c))
      )
    }
    if (filters.materials.length > 0) {
      result = result.filter((p) =>
        p.attributes.material.some((m) => filters.materials.includes(m))
      )
    }
    if (filters.styles.length > 0) {
      result = result.filter((p) =>
        p.attributes.style.some((s) => filters.styles.includes(s))
      )
    }
    if (filters.rooms.length > 0) {
      result = result.filter((p) =>
        p.attributes.room.some((r) => filters.rooms.includes(r))
      )
    }

    const [minPrice, maxPrice] = filters.priceRange
    if (minPrice > 0 || maxPrice < 1000) {
      result = result.filter((p) => p.price >= minPrice && p.price <= maxPrice)
    }

    switch (filters.sort) {
      case 'price-asc':
        result.sort((a, b) => a.price - b.price)
        break
      case 'price-desc':
        result.sort((a, b) => b.price - a.price)
        break
      case 'newest':
        result.sort((a, b) => b.createdAt.localeCompare(a.createdAt))
        break
      case 'top-rated':
        result.sort((a, b) => b.avgRating - a.avgRating)
        break
    }

    return result
  }, [slug, filters])

  // Extract unique filter options from category products
  const categoryProducts = products.filter((p) => p.categorySlug === slug)
  const availableColors = [...new Set(categoryProducts.flatMap((p) => p.attributes.color))]
  const availableMaterials = [...new Set(categoryProducts.flatMap((p) => p.attributes.material))]
  const availableStyles = [...new Set(categoryProducts.flatMap((p) => p.attributes.style))]
  const availableRooms = [...new Set(categoryProducts.flatMap((p) => p.attributes.room))]

  if (!category) {
    return (
      <div className="container-page py-20 text-center">
        <h1 className="text-2xl font-display">Category not found</h1>
      </div>
    )
  }

  return (
    <div className="container-page py-6">
      <Breadcrumbs
        items={[
          { label: 'Home', href: '/' },
          { label: category.name },
        ]}
        className="mb-4"
      />

      <h1 className="font-display text-3xl font-bold mb-2">{category.name}</h1>

      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          {/* Mobile filter trigger */}
          <Sheet>
            <SheetTrigger asChild>
              <Button variant="outline" size="sm" className="lg:hidden gap-2">
                <SlidersHorizontal size={14} />
                Filters
              </Button>
            </SheetTrigger>
            <SheetContent side="left" className="w-[300px] overflow-y-auto p-0">
              <SheetTitle className="sr-only">Filter products</SheetTitle>
              <div className="p-6">
                <FilterSidebar
                  availableColors={availableColors}
                  availableMaterials={availableMaterials}
                  availableStyles={availableStyles}
                  availableRooms={availableRooms}
                />
              </div>
            </SheetContent>
          </Sheet>

          <p className="text-sm text-muted-foreground">
            {filteredProducts.length} product{filteredProducts.length !== 1 ? 's' : ''}
          </p>

          {filters.hasActiveFilters() && (
            <button
              onClick={filters.clearFilters}
              className="flex items-center gap-1 text-xs text-muted-foreground hover:text-foreground transition-colors"
            >
              <X size={12} />
              Clear all
            </button>
          )}
        </div>

        {/* Sort dropdown */}
        <select
          value={filters.sort}
          onChange={(e) => filters.setSort(e.target.value as SortOption)}
          className="text-sm border border-border rounded px-3 py-1.5 bg-background font-body"
        >
          {sortOptions.map((opt) => (
            <option key={opt.value} value={opt.value}>
              {opt.label}
            </option>
          ))}
        </select>
      </div>

      <div className="flex gap-8">
        {/* Desktop filter sidebar */}
        <aside className="hidden lg:block w-60 flex-shrink-0">
          <FilterSidebar
            availableColors={availableColors}
            availableMaterials={availableMaterials}
            availableStyles={availableStyles}
            availableRooms={availableRooms}
          />
        </aside>

        {/* Product grid */}
        <div className="flex-1">
          {filteredProducts.length === 0 ? (
            <div className="py-20 text-center">
              <p className="text-muted-foreground mb-4">No products match your filters.</p>
              <Button variant="outline" onClick={filters.clearFilters}>
                Clear Filters
              </Button>
            </div>
          ) : (
            <div className="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-4">
              {filteredProducts.map((product) => (
                <ProductCard key={product.id} product={product} />
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
