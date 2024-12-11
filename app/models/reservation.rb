class Reservation < ApplicationRecord

  belongs_to :store
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :rsv_time
  belongs_to :service_type

end
