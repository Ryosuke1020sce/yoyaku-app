class CreateRsvNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :rsv_numbers do |t|
      t.string :unique_number, null: false, unique: true
      t.references :guest,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
