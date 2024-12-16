class RsvGroup < ApplicationRecord

  belongs_to :calendar
  has_many :reservations

end
