class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|
      t.integer :part_id
      t.string :supplier
      t.string :supplier_partno
      t.string :manu_partno
      t.float :price
      t.integer :quantity
      t.float :cost
      t.string :supplier_desc

      t.timestamps
    end
  end

  def self.down
    drop_table :order_lines
  end
end
