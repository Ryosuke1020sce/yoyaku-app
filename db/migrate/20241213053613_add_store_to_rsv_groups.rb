class AddStoreToRsvGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :rsv_groups, :store, null: false, foreign_key: true
  end
end
