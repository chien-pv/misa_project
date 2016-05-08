class PurchaseOrder < ActiveRecord::Base
  establish_connection DB_CONF
  self.table_name = 'PUOrder'

  enum Status: ["Chưa thực hiện", "Đang thực hiện", "Hoàn thành" ]

  has_many :pu_order_detail, foreign_key: :RefID
end
