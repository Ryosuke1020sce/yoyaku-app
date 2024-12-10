class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date       :rsv_date,        null: false
      t.integer    :rsv_time_id,     null: false
      t.integer    :service_type_id, null: false
      t.integer    :upper_people_n,  null: false
      t.integer    :fee,             null: false
      t.references :store,           null: false, foreign_key: true
      t.timestamps
    end
  end
end

