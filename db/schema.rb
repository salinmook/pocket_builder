# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_24_213850) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.text "address_line", null: false
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.boolean "is_default", default: false, null: false
    t.string "label"
    t.string "name", null: false
    t.string "phone", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.datetime "created_at", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "coupon_id"
    t.datetime "created_at", null: false
    t.bigint "customer_id"
    t.bigint "store_id"
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_carts_on_coupon_id"
    t.index ["customer_id"], name: "index_carts_on_customer_id"
    t.index ["store_id"], name: "index_carts_on_store_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "store_id", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_categories_on_store_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.string "discount_type", default: "percentage", null: false
    t.decimal "discount_value", precision: 10, scale: 2
    t.datetime "ends_at"
    t.decimal "minimum_order_amount", precision: 10, scale: 2
    t.datetime "starts_at"
    t.bigint "store_id", null: false
    t.datetime "updated_at", null: false
    t.integer "usage_count", default: 0, null: false
    t.integer "usage_limit"
    t.index ["store_id", "code"], name: "index_coupons_on_store_id_and_code", unique: true
    t.index ["store_id"], name: "index_coupons_on_store_id"
  end

  create_table "customers", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.bigint "store_id", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["store_id", "email"], name: "index_customers_on_store_id_and_email", unique: true
    t.index ["store_id"], name: "index_customers_on_store_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "order_id", null: false
    t.decimal "price"
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "coupon_id"
    t.datetime "created_at", null: false
    t.bigint "customer_id"
    t.decimal "discount_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.text "shipping_address"
    t.string "shipping_name"
    t.string "shipping_phone"
    t.string "status"
    t.bigint "store_id"
    t.string "tracking_number"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["store_id"], name: "index_orders_on_store_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.text "description"
    t.decimal "price", precision: 10, scale: 2
    t.integer "stock", default: 0
    t.bigint "store_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "facebook"
    t.string "font_family"
    t.string "instagram"
    t.string "name"
    t.string "phone"
    t.string "primary_color"
    t.string "theme"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "customers"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "coupons"
  add_foreign_key "carts", "customers"
  add_foreign_key "carts", "stores"
  add_foreign_key "categories", "stores"
  add_foreign_key "coupons", "stores"
  add_foreign_key "customers", "stores"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "coupons"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "stores"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "stores"
  add_foreign_key "stores", "users"
end
