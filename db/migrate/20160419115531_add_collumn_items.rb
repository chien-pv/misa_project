class AddCollumnItems < ActiveRecord::Migration
  def change
    add_column :items, :supplier_id, :string
    add_column :items, :supplier_item_code, :string
  end
end
