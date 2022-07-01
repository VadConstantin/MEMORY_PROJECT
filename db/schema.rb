ActiveRecord::Schema.define(version: 2022_04_13_230540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactions", force: :cascade do |t|
    t.date "date"
    t.integer "order_id"
    t.integer "customer_id"
    t.string "country"
    t.string "product_code"
    t.string "product_description"
    t.integer "quantity"
    t.float "unit_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
