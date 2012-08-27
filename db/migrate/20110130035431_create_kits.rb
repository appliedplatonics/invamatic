class CreateKits < ActiveRecord::Migration
  def self.up
    create_table :kits do |t|
      t.string :name
      t.string :description
      t.integer :onhand

      t.timestamps
    end
  end

  def self.down
    drop_table :kits
  end
end
