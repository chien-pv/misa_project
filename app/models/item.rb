class Item < ActiveRecord::Base
  acts_as_paranoid
  has_one :account_object , foreign_key: :AccountObjectID, primary_key: :supplier_id
end
