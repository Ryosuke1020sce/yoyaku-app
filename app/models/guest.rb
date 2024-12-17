class Guest < ApplicationRecord

  belongs_to :reservation
  has_one :rsv_number
  
end
