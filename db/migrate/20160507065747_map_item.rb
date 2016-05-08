class MapItem < ActiveRecord::Migration
  def change
    create_table :map_item do |t|
      t.string :ItemID
      t.string :map_purchase_id
      t.integer :quantity
      
      t.timestamps null: false
    end
  end
end
