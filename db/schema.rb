# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160216164643) do

  create_table "administration_routes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "authorizations", force: :cascade do |t|
    t.integer  "seller_id",  limit: 4
    t.integer  "client_id",  limit: 4
    t.text     "products",   limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "status",     limit: 255
    t.text     "message",    limit: 65535
    t.integer  "points",     limit: 4,     default: 0
  end

  add_index "authorizations", ["client_id"], name: "index_authorizations_on_client_id", using: :btree
  add_index "authorizations", ["seller_id"], name: "index_authorizations_on_seller_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.text     "text",             limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "drugs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "laboratories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "period_products", force: :cascade do |t|
    t.integer  "pfpc_period_id", limit: 4
    t.integer  "product_id",     limit: 4
    t.integer  "amount",         limit: 4
    t.integer  "accumulated",    limit: 4, default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "period_products", ["pfpc_period_id"], name: "index_period_products_on_pfpc_period_id", using: :btree
  add_index "period_products", ["product_id"], name: "index_period_products_on_product_id", using: :btree

  create_table "pfpc_periods", force: :cascade do |t|
    t.integer  "service_id", limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "status",     limit: 4, default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "pfpc_periods", ["service_id"], name: "index_pfpc_periods_on_service_id", using: :btree

  create_table "pfpc_suppliers", force: :cascade do |t|
    t.integer "pfpc_service_id", limit: 4
    t.integer "supplier_id",     limit: 4
  end

  add_index "pfpc_suppliers", ["pfpc_service_id"], name: "index_pfpc_suppliers_on_pfpc_service_id", using: :btree
  add_index "pfpc_suppliers", ["supplier_id"], name: "index_pfpc_suppliers_on_supplier_id", using: :btree

  create_table "pharmacologic_actions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pharmacologic_forms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "points_periods", force: :cascade do |t|
    t.integer  "service_id",  limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "status",      limit: 4, default: 0
    t.integer  "amount",      limit: 4, default: 0
    t.integer  "accumulated", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "available",   limit: 4, default: 0
  end

  add_index "points_periods", ["service_id"], name: "index_points_periods_on_service_id", using: :btree

  create_table "potency_units", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "presentation_sizes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "product_discounts", force: :cascade do |t|
    t.integer  "product_id",   limit: 4
    t.integer  "vademecum_id", limit: 4
    t.float    "discount",     limit: 24, default: 0.0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "product_discounts", ["product_id"], name: "index_product_discounts_on_product_id", using: :btree
  add_index "product_discounts", ["vademecum_id"], name: "index_product_discounts_on_vademecum_id", using: :btree

  create_table "product_pfpcs", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "service_id", limit: 4
    t.integer  "amount",     limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "product_pfpcs", ["product_id"], name: "index_product_pfpcs_on_product_id", using: :btree
  add_index "product_pfpcs", ["service_id"], name: "index_product_pfpcs_on_service_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "code",                       limit: 255,                 null: false
    t.string   "name",                       limit: 255,                 null: false
    t.integer  "points",                     limit: 4
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "barcode",                    limit: 255
    t.string   "presentation_form",          limit: 255
    t.float    "price",                      limit: 24
    t.date     "expiration_date"
    t.boolean  "imported"
    t.integer  "sell_type",                  limit: 4
    t.integer  "registration_number",        limit: 4
    t.boolean  "deleted",                                default: false
    t.integer  "units",                      limit: 4,   default: 1
    t.integer  "size",                       limit: 4
    t.string   "potency",                    limit: 255
    t.string   "troquel_number",             limit: 255
    t.integer  "relative_presentation_size", limit: 4
    t.integer  "pharmacologic_action_id",    limit: 4
    t.integer  "drug_id",                    limit: 4
    t.integer  "pharmacologic_form_id",      limit: 4
    t.integer  "potency_unit_id",            limit: 4
    t.integer  "unit_type_id",               limit: 4
    t.integer  "administration_route_id",    limit: 4
    t.integer  "laboratory_id",              limit: 4
  end

  add_index "products", ["administration_route_id"], name: "index_products_on_administration_route_id", using: :btree
  add_index "products", ["drug_id"], name: "index_products_on_drug_id", using: :btree
  add_index "products", ["laboratory_id"], name: "index_products_on_laboratory_id", using: :btree
  add_index "products", ["pharmacologic_action_id"], name: "index_products_on_pharmacologic_action_id", using: :btree
  add_index "products", ["pharmacologic_form_id"], name: "index_products_on_pharmacologic_form_id", using: :btree
  add_index "products", ["potency_unit_id"], name: "index_products_on_potency_unit_id", using: :btree
  add_index "products", ["relative_presentation_size"], name: "index_products_on_relative_presentation_size", using: :btree
  add_index "products", ["unit_type_id"], name: "index_products_on_unit_type_id", using: :btree

  create_table "reward_order_items", force: :cascade do |t|
    t.integer  "reward_order_id", limit: 4
    t.integer  "reward_id",       limit: 4
    t.integer  "amount",          limit: 4
    t.integer  "need_points",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "reward_order_items", ["reward_id"], name: "index_reward_order_items_on_reward_id", using: :btree
  add_index "reward_order_items", ["reward_order_id"], name: "index_reward_order_items_on_reward_order_id", using: :btree

  create_table "reward_orders", force: :cascade do |t|
    t.integer  "supplier_id",  limit: 4
    t.integer  "user_id",      limit: 4
    t.string   "state",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "code",         limit: 255
    t.string   "qr_code_uid",  limit: 255
    t.string   "qr_code_name", limit: 255
  end

  add_index "reward_orders", ["supplier_id"], name: "index_reward_orders_on_supplier_id", using: :btree
  add_index "reward_orders", ["user_id"], name: "index_reward_orders_on_user_id", using: :btree

  create_table "rewards", force: :cascade do |t|
    t.string   "name",          limit: 255,   null: false
    t.text     "description",   limit: 65535
    t.string   "code",          limit: 255,   null: false
    t.integer  "need_points",   limit: 4
    t.string   "reward_kind",   limit: 255,   null: false
    t.string   "image_uid",     limit: 255
    t.string   "image_name",    limit: 255
    t.text     "service_types", limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "sale_products", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "sale_id",    limit: 4
    t.integer  "amount",     limit: 4,  default: 1
    t.float    "cost",       limit: 24, default: 0.0
    t.float    "discount",   limit: 24, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total",      limit: 24, default: 0.0
  end

  add_index "sale_products", ["product_id"], name: "index_sale_products_on_product_id", using: :btree
  add_index "sale_products", ["sale_id"], name: "index_sale_products_on_sale_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.integer  "seller_id",  limit: 4
    t.integer  "client_id",  limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "points",     limit: 4,  default: 0
    t.float    "total",      limit: 24, default: 0.0
  end

  add_index "sales", ["client_id"], name: "index_sales_on_client_id", using: :btree
  add_index "sales", ["seller_id"], name: "index_sales_on_seller_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",                      limit: 255,                 null: false
    t.string   "type",                      limit: 255,                 null: false
    t.integer  "user_id",                   limit: 4
    t.integer  "last_period_id",            limit: 4
    t.integer  "amount",                    limit: 4
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "days",                      limit: 4,   default: 30
    t.integer  "vademecum_id",              limit: 4
    t.integer  "status",                    limit: 4,   default: 0
    t.integer  "days_to_points_expiration", limit: 4
    t.boolean  "always_discount",                       default: false
  end

  add_index "services", ["last_period_id"], name: "index_services_on_last_period_id", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree
  add_index "services", ["vademecum_id"], name: "index_services_on_vademecum_id", using: :btree

  create_table "stock_entries", force: :cascade do |t|
    t.string   "codename",      limit: 255
    t.integer  "owner_id",      limit: 4
    t.string   "owner_type",    limit: 255
    t.integer  "stock_id",      limit: 4
    t.integer  "amount_in_int", limit: 4,     default: 0
    t.date     "entry_date"
    t.text     "observation",   limit: 65535
    t.boolean  "special",                     default: false
    t.boolean  "applied",                     default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "stock_entries", ["owner_type", "owner_id"], name: "index_stock_entries_on_owner_type_and_owner_id", using: :btree
  add_index "stock_entries", ["stock_id"], name: "index_stock_entries_on_stock_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "real_stock_in_int",      limit: 4,   default: 0
    t.integer  "warehouse_stock_in_int", limit: 4,   default: 0
    t.integer  "stockable_id",           limit: 4
    t.string   "stockable_type",         limit: 255
    t.integer  "store_id",               limit: 4
    t.string   "store_type",             limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "stocks", ["stockable_type", "stockable_id"], name: "index_stocks_on_stockable_type_and_stockable_id", using: :btree

  create_table "supplier_point_products", force: :cascade do |t|
    t.integer  "supplier_id", limit: 4
    t.integer  "product_id",  limit: 4
    t.integer  "points",      limit: 4, default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "supplier_point_products", ["product_id"], name: "index_supplier_point_products_on_product_id", using: :btree
  add_index "supplier_point_products", ["supplier_id"], name: "index_supplier_point_products_on_supplier_id", using: :btree

  create_table "supplier_requests", force: :cascade do |t|
    t.integer  "supplier_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "created_by_id",   limit: 4
    t.datetime "resolution_date"
    t.integer  "status",          limit: 4,     default: 0
    t.string   "first_name",      limit: 255,               null: false
    t.string   "last_name",       limit: 255,               null: false
    t.string   "document_type",   limit: 255,               null: false
    t.string   "document_number", limit: 255,               null: false
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.string   "address",         limit: 255
    t.text     "notes",           limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "supplier_requests", ["created_by_id"], name: "index_supplier_requests_on_created_by_id", using: :btree
  add_index "supplier_requests", ["supplier_id"], name: "index_supplier_requests_on_supplier_id", using: :btree
  add_index "supplier_requests", ["user_id"], name: "index_supplier_requests_on_user_id", using: :btree

  create_table "supplier_vademecums", force: :cascade do |t|
    t.integer  "supplier_id",  limit: 4
    t.integer  "vademecum_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "supplier_vademecums", ["supplier_id"], name: "index_supplier_vademecums_on_supplier_id", using: :btree
  add_index "supplier_vademecums", ["vademecum_id"], name: "index_supplier_vademecums_on_vademecum_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.text     "description",      limit: 65535
    t.boolean  "active"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "city",             limit: 255
    t.string   "address",          limit: 255
    t.string   "latitude",         limit: 255
    t.string   "longitude",        limit: 255
    t.string   "telephone",        limit: 255
    t.string   "email",            limit: 255
    t.boolean  "points_to_client"
    t.boolean  "points_to_seller"
    t.text     "contact_info",     limit: 65535
  end

  create_table "unit_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           limit: 255,                 null: false
    t.string   "crypted_password",                limit: 255
    t.string   "salt",                            limit: 255
    t.string   "role",                            limit: 255
    t.string   "first_name",                      limit: 255
    t.string   "last_name",                       limit: 255
    t.integer  "created_by_id",                   limit: 4
    t.integer  "supplier_id",                     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token",               limit: 255
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token",            limit: 255
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "number",                          limit: 4
    t.string   "document_type",                   limit: 255
    t.string   "document_number",                 limit: 255
    t.string   "phone",                           limit: 255
    t.string   "address",                         limit: 255
    t.string   "username",                        limit: 255
    t.string   "image_uid",                       limit: 255
    t.string   "image_name",                      limit: 255
    t.string   "card_number",                     limit: 255
    t.boolean  "terms_accepted",                              default: false
    t.boolean  "card_printed",                                default: false
    t.boolean  "card_delivered",                              default: false
    t.integer  "cache_points",                    limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["supplier_id"], name: "index_users_on_supplier_id", using: :btree

  create_table "vademecums", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "period_products", "pfpc_periods"
  add_foreign_key "period_products", "products"
  add_foreign_key "pfpc_periods", "services"
  add_foreign_key "pfpc_suppliers", "services", column: "pfpc_service_id"
  add_foreign_key "pfpc_suppliers", "suppliers"
  add_foreign_key "points_periods", "services"
  add_foreign_key "product_discounts", "products"
  add_foreign_key "product_discounts", "vademecums"
  add_foreign_key "product_pfpcs", "products"
  add_foreign_key "product_pfpcs", "services"
  add_foreign_key "products", "administration_routes"
  add_foreign_key "products", "drugs"
  add_foreign_key "products", "laboratories"
  add_foreign_key "products", "pharmacologic_actions"
  add_foreign_key "products", "pharmacologic_forms"
  add_foreign_key "products", "potency_units"
  add_foreign_key "products", "unit_types"
  add_foreign_key "reward_order_items", "reward_orders"
  add_foreign_key "reward_order_items", "rewards"
  add_foreign_key "reward_orders", "suppliers"
  add_foreign_key "reward_orders", "users"
  add_foreign_key "sale_products", "products"
  add_foreign_key "sale_products", "sales"
  add_foreign_key "services", "users"
  add_foreign_key "services", "vademecums"
  add_foreign_key "supplier_point_products", "products"
  add_foreign_key "supplier_point_products", "suppliers"
  add_foreign_key "supplier_requests", "suppliers"
  add_foreign_key "supplier_requests", "users"
  add_foreign_key "supplier_vademecums", "suppliers"
  add_foreign_key "supplier_vademecums", "vademecums"
end
