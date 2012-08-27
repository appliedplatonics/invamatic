class CreateKitActions < ActiveRecord::Migration
  def self.up
    create_table :kit_actions do |t|
      t.integer :kit_id
      t.string :action
      t.integer :n

      t.timestamps
    end
  end

  def self.down
    drop_table :kit_actions
  end
end
