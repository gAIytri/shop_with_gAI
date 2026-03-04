import { create } from 'zustand'
import type { User } from '@/types'

interface AuthStore {
  user: User | null
  isAuthenticated: boolean
  token: string | null

  login: (user: User, token: string) => void
  logout: () => void
  updateUser: (updates: Partial<User>) => void
}

export const useAuthStore = create<AuthStore>((set, get) => ({
  user: null,
  isAuthenticated: false,
  token: null,

  login: (user, token) => set({ user, isAuthenticated: true, token }),

  logout: () => set({ user: null, isAuthenticated: false, token: null }),

  updateUser: (updates) => {
    const { user } = get()
    if (user) {
      set({ user: { ...user, ...updates } })
    }
  },
}))
