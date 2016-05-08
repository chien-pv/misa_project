class AddColumnItemId < ActiveRecord::Migration
  def change
    add_column :items, :item_id, :string
  end
end
