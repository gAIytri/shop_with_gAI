import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { mockUser } from '@/mocks'

export function ProfilePage() {
  return (
    <div>
      <h2 className="font-display text-lg font-semibold mb-6">Profile</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 max-w-lg">
        <div>
          <Label htmlFor="firstName">First Name</Label>
          <Input id="firstName" defaultValue={mockUser.firstName} className="mt-1" />
        </div>
        <div>
          <Label htmlFor="lastName">Last Name</Label>
          <Input id="lastName" defaultValue={mockUser.lastName} className="mt-1" />
        </div>
        <div className="sm:col-span-2">
          <Label htmlFor="email">Email</Label>
          <Input id="email" type="email" defaultValue={mockUser.email} className="mt-1" />
        </div>
        <div className="sm:col-span-2">
          <Label htmlFor="phone">Phone</Label>
          <Input id="phone" defaultValue={mockUser.phone} className="mt-1" />
        </div>
      </div>
      <Button className="mt-6">Save Changes</Button>
    </div>
  )
}
