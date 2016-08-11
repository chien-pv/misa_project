class MapPurchase < ActiveRecord::Base
  has_many :purchase_order, foreign_key: :RefID, primary_key: :RefID
  has_many :map_item, foreign_key: :map_purchase_id

  validates_presence_of :map_id
end
