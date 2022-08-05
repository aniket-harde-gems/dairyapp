# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_29_142431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_delivery_preferences", force: :cascade do |t|
    t.integer "milkman_customer_id"
    t.integer "milkman_product_id"
    t.string "shift"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "starting_date"
    t.date "ending_date"
  end

  create_table "customer_delivery_recurrings", force: :cascade do |t|
    t.integer "customer_delivery_preference_id"
    t.integer "recurring_type"
    t.integer "day_of_week"
    t.integer "seperation_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "milkman_customer_products", force: :cascade do |t|
    t.integer "milkman_customer_id"
    t.integer "milkman_product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "milkman_customers", force: :cascade do |t|
    t.string "customer_name"
    t.string "customer_address"
    t.string "customer_mobile_number"
    t.bigint "milkman_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["milkman_id"], name: "index_milkman_customers_on_milkman_id"
  end

  create_table "milkman_products", force: :cascade do |t|
    t.string "product_name"
    t.integer "product_price"
    t.bigint "milkman_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["milkman_id"], name: "index_milkman_products_on_milkman_id"
  end

  create_table "milkmen", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "milkman_customers", "milkmen"
  add_foreign_key "milkman_products", "milkmen"
end
