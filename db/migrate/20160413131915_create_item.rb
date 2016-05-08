class CreateItem < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_code
      t.float :volume
      t.float :weight

      t.timestamps null: false
    end
  end
end
