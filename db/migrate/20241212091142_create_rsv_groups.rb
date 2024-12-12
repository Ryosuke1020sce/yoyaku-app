class CreateRsvGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :rsv_groups do |t|
      t.timestamps
    end
  end
end
