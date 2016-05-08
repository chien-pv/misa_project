class MapPurchase < ActiveRecord::Migration
  def change
    create_table :map_purchases do |t|
      t.string :RefID
      t.string :map_id
      t.date :date_map

      t.timestamps null: false
    end
  end
end