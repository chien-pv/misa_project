class MapItem < ActiveRecord::Base
  self.table_name = 'map_item'
  has_many :pu_order_detail ,foreign_key: :InventoryItemID, primary_key: :ItemID
end
