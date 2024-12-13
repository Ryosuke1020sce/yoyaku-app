class Store < ApplicationRecord

  belongs_to :user
  has_many :reservations
  has_many :rsv_groups
  has_many :calendars

end
