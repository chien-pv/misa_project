class AccountObject < ActiveRecord::Base
  establish_connection DB_CONF
  self.table_name = 'AccountObject'
  has_many :item, foreign_key: :supplier_id
  has_one :account_object, primary_key: :AccountObjectID
end
