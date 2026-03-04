import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion'
import { Checkbox } from '@/components/ui/checkbox'
import { Slider } from '@/components/ui/slider'
import { useFilterStore } from '@/stores/filterStore'

interface FilterSidebarProps {
  availableColors: string[]
  availableMaterials: string[]
  availableStyles: string[]
  availableRooms: string[]
}

export function FilterSidebar({
  availableColors,
  availableMaterials,
  availableStyles,
  availableRooms,
}: FilterSidebarProps) {
  const filters = useFilterStore()

  return (
    <div>
      <h3 className="font-body text-xs font-semibold uppercase tracking-[1px] mb-4">
        Filter By
      </h3>

      <Accordion type="multiple" defaultValue={['color', 'material', 'style', 'price', 'room']}>
        {/* Color */}
        {availableColors.length > 0 && (
          <AccordionItem value="color">
            <AccordionTrigger className="text-sm font-medium py-3">Color</AccordionTrigger>
            <AccordionContent>
              <div className="space-y-2 pb-2">
                {availableColors.map((color) => (
                  <label key={color} className="flex items-center gap-2 cursor-pointer">
                    <Checkbox
                      checked={filters.colors.includes(color)}
                      onCheckedChange={() => filters.toggleColor(color)}
                    />
                    <span className="text-sm">{color}</span>
                  </label>
                ))}
              </div>
            </AccordionContent>
          </AccordionItem>
        )}

        {/* Material */}
        {availableMaterials.length > 0 && (
          <AccordionItem value="material">
            <AccordionTrigger className="text-sm font-medium py-3">Material</AccordionTrigger>
            <AccordionContent>
              <div className="space-y-2 pb-2">
                {availableMaterials.map((material) => (
                  <label key={material} className="flex items-center gap-2 cursor-pointer">
                    <Checkbox
                      checked={filters.materials.includes(material)}
                      onCheckedChange={() => filters.toggleMaterial(material)}
                    />
                    <span className="text-sm">{material}</span>
                  </label>
                ))}
              </div>
            </AccordionContent>
          </AccordionItem>
        )}

        {/* Style */}
        {availableStyles.length > 0 && (
          <AccordionItem value="style">
            <AccordionTrigger className="text-sm font-medium py-3">Style</AccordionTrigger>
            <AccordionContent>
              <div className="space-y-2 pb-2">
                {availableStyles.map((style) => (
                  <label key={style} className="flex items-center gap-2 cursor-pointer">
                    <Checkbox
                      checked={filters.styles.includes(style)}
                      onCheckedChange={() => filters.toggleStyle(style)}
                    />
                    <span className="text-sm">{style}</span>
                  </label>
                ))}
              </div>
            </AccordionContent>
          </AccordionItem>
        )}

        {/* Price Range */}
        <AccordionItem value="price">
          <AccordionTrigger className="text-sm font-medium py-3">Price</AccordionTrigger>
          <AccordionContent>
            <div className="px-1 pb-2">
              <Slider
                min={0}
                max={1000}
                step={10}
                value={filters.priceRange}
                onValueChange={(val) => filters.setPriceRange(val as [number, number])}
              />
              <div className="flex justify-between mt-2 text-xs text-muted-foreground">
                <span>${filters.priceRange[0]}</span>
                <span>${filters.priceRange[1]}</span>
              </div>
            </div>
          </AccordionContent>
        </AccordionItem>

        {/* Room */}
        {availableRooms.length > 0 && (
          <AccordionItem value="room">
            <AccordionTrigger className="text-sm font-medium py-3">Room</AccordionTrigger>
            <AccordionContent>
              <div className="space-y-2 pb-2">
                {availableRooms.map((room) => (
                  <label key={room} className="flex items-center gap-2 cursor-pointer">
                    <Checkbox
                      checked={filters.rooms.includes(room)}
                      onCheckedChange={() => filters.toggleRoom(room)}
                    />
                    <span className="text-sm">{room}</span>
                  </label>
                ))}
              </div>
            </AccordionContent>
          </AccordionItem>
        )}
      </Accordion>
    </div>
  )
}
