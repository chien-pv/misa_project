class PurchaseOrder < ActiveRecord::Migration
  def change
    create_table :purchase_order do |t|
      t.integer :status
      t.datetime :order_date
      t.string :order_code
      t.datetime :receive_date
      t.string :supplier
      t.text :description
      t.integer :amount
      t.integer :supplier_id
      t.text :supplier_address
      t.string :bank_account
      t.string :supplier_phone
      
      t.timestamps null: false
    end
  end
end
