class CreateContainerType < ActiveRecord::Migration
  def change
    create_table :container_types do |t|
      t.string :container_type_code
      t.string :container_type_name
      t.float :volume
      t.float :weight
    end
  end
end

