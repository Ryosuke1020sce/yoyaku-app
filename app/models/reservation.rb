class Reservation < ApplicationRecord

  belongs_to :store

  belongs_to :rsv_time
  belongs_to :service_type

end
