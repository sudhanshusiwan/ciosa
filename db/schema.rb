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

ActiveRecord::Schema.define(version: 20161112223807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cart_products", force: :cascade do |t|
    t.integer  "product_id", null: false
    t.integer  "user_id",    null: false
    t.integer  "quantity",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "ordered_products", force: :cascade do |t|
    t.integer  "product_id", null: false
    t.integer  "order_id",   null: false
    t.integer  "price",      null: false
    t.integer  "quantity",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.integer  "total_price",      null: false
    t.string   "billing_address",  null: false
    t.string   "delivery_address", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: :cascade do |t|
    t.string  "name",              default: "", null: false
    t.string  "address"
    t.integer "creator_id",                     null: false
    t.string  "email",             default: "", null: false
    t.string  "mobile",            default: "", null: false
    t.string  "organization_type", default: "", null: false
    t.string  "pan_tin_number",    default: "", null: false
    t.boolean "is_store",                       null: false
    t.boolean "is_eco_friendly",                null: false
    t.boolean "can_do_logistics",               null: false
    t.string  "products_sold"
    t.boolean "is_approved"
  end

  add_index "organizations", ["can_do_logistics"], name: "index_organizations_on_can_do_logistics", using: :btree
  add_index "organizations", ["creator_id"], name: "index_organizations_on_creator_id", using: :btree
  add_index "organizations", ["email"], name: "index_organizations_on_email", unique: true, using: :btree
  add_index "organizations", ["is_eco_friendly"], name: "index_organizations_on_is_eco_friendly", using: :btree
  add_index "organizations", ["is_store"], name: "index_organizations_on_is_store", using: :btree
  add_index "organizations", ["mobile"], name: "index_organizations_on_mobile", unique: true, using: :btree
  add_index "organizations", ["organization_type"], name: "index_organizations_on_organization_type", using: :btree

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_id",  null: false
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_categories", ["product_id", "category_id"], name: "product_category_index", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",               null: false
    t.text     "description",        null: false
    t.integer  "price",              null: false
    t.boolean  "is_approved"
    t.integer  "available_quantity", null: false
    t.integer  "creator_id",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "mobile",                 default: "", null: false
    t.string   "address"
    t.string   "user_type",              default: "", null: false
    t.integer  "organization_id"
    t.string   "pan_number"
    t.string   "bank_name"
    t.string   "account_number"
    t.boolean  "is_approved"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_type"], name: "index_users_on_user_type", using: :btree

end
