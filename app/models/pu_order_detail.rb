class PuOrderDetail < ActiveRecord::Base
  establish_connection DB_CONF
  self.table_name = 'PuOrderDetail'

  belongs_to :purchase_order, foreign_key: :RefID
  has_one :item , foreign_key: :item_id, primary_key: :InventoryItemID
end
