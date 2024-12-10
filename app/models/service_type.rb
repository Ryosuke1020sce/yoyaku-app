class ServiceType < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '部屋' },
    { id: 3, name: '席' },
    { id: 4, name: '枠' }
  ]

  include ActiveHash::Associations
  has_many :reservations
end