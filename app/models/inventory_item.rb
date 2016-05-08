class InventoryItem < ActiveRecord::Base
  establish_connection DB_CONF
  self.table_name = 'InventoryItem'
  has_one :unit, foreign_key: :UnitID, primary_key: :UnitID
  has_many :item, foreign_key: :item_id, primary_key: :InventoryItemID
end
