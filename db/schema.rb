# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110130053530) do

  create_table "kit_actions", :force => true do |t|
    t.integer  "kit_id"
    t.string   "action"
    t.integer  "n"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kit_lines", :force => true do |t|
    t.integer  "kit_id"
    t.integer  "part_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kits", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "onhand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_lines", :force => true do |t|
    t.integer  "part_id"
    t.string   "supplier"
    t.string   "supplier_partno"
    t.string   "manu_partno"
    t.float    "price"
    t.integer  "quantity"
    t.float    "cost"
    t.string   "supplier_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.string   "group"
    t.string   "value"
    t.string   "description"
    t.integer  "onhand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
