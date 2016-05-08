class AddDeletedAt < ActiveRecord::Migration
  def change
    add_column :items, :deleted_at, :datetime
    add_column :purchase_order, :deleted_at, :datetime
    add_column :container_types, :deleted_at, :datetime
  end
end
