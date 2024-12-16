class RemoveStoreFromRsvGroups < ActiveRecord::Migration[7.0]
  def change
    remove_reference :rsv_groups, :store, null: false, foreign_key: true
  end
end
