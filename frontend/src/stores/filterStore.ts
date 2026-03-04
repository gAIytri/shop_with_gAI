import { create } from 'zustand'
import type { FilterState, SortOption } from '@/types'

interface FilterStore extends FilterState {
  setColors: (colors: string[]) => void
  toggleColor: (color: string) => void
  setMaterials: (materials: string[]) => void
  toggleMaterial: (material: string) => void
  setStyles: (styles: string[]) => void
  toggleStyle: (style: string) => void
  setRooms: (rooms: string[]) => void
  toggleRoom: (room: string) => void
  setPriceRange: (range: [number, number]) => void
  setSort: (sort: SortOption) => void
  setPage: (page: number) => void
  clearFilters: () => void
  hasActiveFilters: () => boolean
}

const initialState: FilterState = {
  colors: [],
  materials: [],
  styles: [],
  rooms: [],
  priceRange: [0, 1000],
  sort: 'best-selling',
  page: 1,
  perPage: 20,
}

function toggleItem(arr: string[], item: string): string[] {
  return arr.includes(item) ? arr.filter((i) => i !== item) : [...arr, item]
}

export const useFilterStore = create<FilterStore>((set, get) => ({
  ...initialState,

  setColors: (colors) => set({ colors, page: 1 }),
  toggleColor: (color) => set({ colors: toggleItem(get().colors, color), page: 1 }),
  setMaterials: (materials) => set({ materials, page: 1 }),
  toggleMaterial: (material) => set({ materials: toggleItem(get().materials, material), page: 1 }),
  setStyles: (styles) => set({ styles, page: 1 }),
  toggleStyle: (style) => set({ styles: toggleItem(get().styles, style), page: 1 }),
  setRooms: (rooms) => set({ rooms, page: 1 }),
  toggleRoom: (room) => set({ rooms: toggleItem(get().rooms, room), page: 1 }),
  setPriceRange: (priceRange) => set({ priceRange, page: 1 }),
  setSort: (sort) => set({ sort, page: 1 }),
  setPage: (page) => set({ page }),

  clearFilters: () => set(initialState),

  hasActiveFilters: () => {
    const s = get()
    return (
      s.colors.length > 0 ||
      s.materials.length > 0 ||
      s.styles.length > 0 ||
      s.rooms.length > 0 ||
      s.priceRange[0] > 0 ||
      s.priceRange[1] < 1000
    )
  },
}))
