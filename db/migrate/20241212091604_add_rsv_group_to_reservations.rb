class AddRsvGroupToReservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :rsv_group, foreign_key: true
  end
end
