class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string     :name,        null: false
      t.string     :mail
      t.integer    :people_n
      t.string     :tel
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end