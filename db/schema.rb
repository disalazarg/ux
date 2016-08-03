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

ActiveRecord::Schema.define(version: 20160803165002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "email"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacts", ["email"], name: "index_contacts_on_email", unique: true, using: :btree
  add_index "contacts", ["school_id"], name: "index_contacts_on_school_id", using: :btree
  add_index "contacts", ["slug"], name: "index_contacts_on_slug", unique: true, using: :btree

  create_table "districts", force: :cascade do |t|
    t.integer  "province_id"
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "lng"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "districts", ["province_id"], name: "index_districts_on_province_id", using: :btree
  add_index "districts", ["slug"], name: "index_districts_on_slug", unique: true, using: :btree

  create_table "polls", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "title"
    t.date     "finish"
    t.text     "intro"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "polls", ["product_id"], name: "index_polls_on_product_id", using: :btree
  add_index "polls", ["slug"], name: "index_polls_on_slug", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "link"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree
  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "provinces", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "lng"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "provinces", ["region_id"], name: "index_provinces_on_region_id", using: :btree
  add_index "provinces", ["slug"], name: "index_provinces_on_slug", unique: true, using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "poll_id"
    t.text     "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["poll_id"], name: "index_questions_on_poll_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "lng"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "regions", ["slug"], name: "index_regions_on_slug", unique: true, using: :btree

  create_table "schools", force: :cascade do |t|
    t.integer  "district_id"
    t.string   "name"
    t.string   "rbd"
    t.integer  "statute_id"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schools", ["district_id"], name: "index_schools_on_district_id", using: :btree
  add_index "schools", ["rbd"], name: "index_schools_on_rbd", unique: true, using: :btree
  add_index "schools", ["slug"], name: "index_schools_on_slug", unique: true, using: :btree
  add_index "schools", ["statute_id"], name: "index_schools_on_statute_id", using: :btree

  create_table "statutes", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "statutes", ["slug"], name: "index_statutes_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "contacts", "schools"
  add_foreign_key "districts", "provinces"
  add_foreign_key "polls", "products"
  add_foreign_key "products", "users"
  add_foreign_key "provinces", "regions"
  add_foreign_key "questions", "polls"
  add_foreign_key "schools", "districts"
  add_foreign_key "schools", "statutes"
end
