class RsvGroup < ApplicationRecord

  belongs_to :store
  has_many :reservations

end
