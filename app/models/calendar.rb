class Calendar < ApplicationRecord

  belongs_to :store
  has_many :rsv_groups
  
end
