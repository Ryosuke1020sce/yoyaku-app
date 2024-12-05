class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string     :store_name,    null: false
      t.text       :store_guide,   null: false
      t.string     :store_address, null: false
      t.string     :store_tel,     null: false
      t.references :user,          null: false, foreign_key: true

      t.timestamps
    end
  end
end
