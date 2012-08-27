class CreateKitLines < ActiveRecord::Migration
  def self.up
    create_table :kit_lines do |t|
      t.integer :kit_id
      t.integer :part_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :kit_lines
  end
end
