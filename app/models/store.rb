class Store < ApplicationRecord

  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :rsv_groups, through: :calendars

  has_one_attached :image

end
