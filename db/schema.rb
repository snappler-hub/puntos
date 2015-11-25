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

ActiveRecord::Schema.define(version: 20151123175820) do

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

  create_table "period_products", force: :cascade do |t|
    t.integer  "service_period_id", limit: 4
    t.integer  "product_id",        limit: 4
    t.integer  "ammount",           limit: 4
    t.integer  "accumulated",       limit: 4, default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "period_products", ["product_id"], name: "index_period_products_on_product_id", using: :btree
  add_index "period_products", ["service_period_id"], name: "index_period_products_on_service_period_id", using: :btree

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
    t.string   "code",       limit: 255, null: false
    t.string   "name",       limit: 255, null: false
    t.integer  "points",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "barcode",    limit: 255
  end

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

  create_table "service_periods", force: :cascade do |t|
    t.integer  "service_id", limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "status",     limit: 4, default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "service_periods", ["service_id"], name: "index_service_periods_on_service_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",         limit: 255,              null: false
    t.string   "type",         limit: 255,              null: false
    t.integer  "user_id",      limit: 4
    t.integer  "amount",       limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "days",         limit: 4,   default: 30
    t.integer  "vademecum_id", limit: 4
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree
  add_index "services", ["vademecum_id"], name: "index_services_on_vademecum_id", using: :btree

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

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "active"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
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
    t.integer  "supplier_request_id",             limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["supplier_id"], name: "index_users_on_supplier_id", using: :btree
  add_index "users", ["supplier_request_id"], name: "index_users_on_supplier_request_id", using: :btree

  create_table "vademecums", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "period_products", "products"
  add_foreign_key "period_products", "service_periods"
  add_foreign_key "product_discounts", "products"
  add_foreign_key "product_discounts", "vademecums"
  add_foreign_key "product_pfpcs", "products"
  add_foreign_key "product_pfpcs", "services"
  add_foreign_key "service_periods", "services"
  add_foreign_key "services", "users"
  add_foreign_key "services", "vademecums"
  add_foreign_key "supplier_requests", "suppliers"
  add_foreign_key "supplier_requests", "users"
  add_foreign_key "users", "supplier_requests"
end
