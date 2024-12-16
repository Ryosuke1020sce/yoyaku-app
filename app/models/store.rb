class Store < ApplicationRecord

  belongs_to :user
  has_many :reservations
  has_many :calendars
  has_many :rsv_groups, through: :calendars

  has_one_attached :image

end
