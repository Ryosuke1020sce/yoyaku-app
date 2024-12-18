class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.date       :std_date, null: false
      t.references :store,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
