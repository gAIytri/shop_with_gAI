import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { mockUser } from '@/mocks'

export function AddressesPage() {
  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h2 className="font-display text-lg font-semibold">Addresses</h2>
        <Button variant="outline" size="sm">Add Address</Button>
      </div>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        {mockUser.addresses.map((addr) => (
          <div key={addr.id} className="border border-border p-4">
            <div className="flex items-center gap-2 mb-2">
              <span className="font-medium text-sm">{addr.label}</span>
              {addr.isDefault && (
                <Badge variant="secondary" className="text-[10px]">Default</Badge>
              )}
            </div>
            <p className="text-sm text-muted-foreground">
              {addr.firstName} {addr.lastName}
            </p>
            <p className="text-sm text-muted-foreground">{addr.street1}</p>
            {addr.street2 && <p className="text-sm text-muted-foreground">{addr.street2}</p>}
            <p className="text-sm text-muted-foreground">
              {addr.city}, {addr.state} {addr.zipCode}
            </p>
            <p className="text-sm text-muted-foreground">{addr.phone}</p>
            <div className="flex gap-3 mt-3">
              <button className="text-xs underline text-muted-foreground hover:text-foreground">
                Edit
              </button>
              {!addr.isDefault && (
                <button className="text-xs underline text-muted-foreground hover:text-foreground">
                  Set as default
                </button>
              )}
              <button className="text-xs underline text-destructive hover:text-destructive/80">
                Delete
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
