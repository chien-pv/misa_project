class InventoryItem < ActiveRecord::Base
  establish_connection DB_CONF
  self.table_name = 'InventoryItem'
end
