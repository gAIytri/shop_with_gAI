import type { User } from '@/types'

export const mockUser: User = {
  id: '1',
  email: 'sarah.johnson@email.com',
  firstName: 'Sarah',
  lastName: 'Johnson',
  phone: '(555) 123-4567',
  addresses: [
    {
      id: 'addr-1',
      label: 'Home',
      firstName: 'Sarah',
      lastName: 'Johnson',
      street1: '742 Evergreen Terrace',
      city: 'Portland',
      state: 'OR',
      zipCode: '97201',
      country: 'US',
      phone: '(555) 123-4567',
      isDefault: true,
    },
    {
      id: 'addr-2',
      label: 'Office',
      firstName: 'Sarah',
      lastName: 'Johnson',
      street1: '200 SW Market St',
      street2: 'Suite 1500',
      city: 'Portland',
      state: 'OR',
      zipCode: '97201',
      country: 'US',
      phone: '(555) 987-6543',
      isDefault: false,
    },
  ],
  createdAt: '2025-06-15T10:00:00Z',
}
