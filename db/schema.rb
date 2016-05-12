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

ActiveRecord::Schema.define(version: 20160512225544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "restaurants", force: :cascade do |t|
    t.string   "business_id"
    t.string   "name"
    t.string   "url"
    t.string   "image_url"
    t.string   "phone"
    t.decimal  "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "spotify_items", force: :cascade do |t|
    t.string   "item_id"
    t.string   "item_type"
    t.string   "name"
    t.string   "url"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer  "restaurant_id",   null: false
    t.integer  "spotify_item_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "suggestions", ["restaurant_id"], name: "index_suggestions_on_restaurant_id", using: :btree
  add_index "suggestions", ["spotify_item_id"], name: "index_suggestions_on_spotify_item_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "oauth_provider"
    t.string   "oauth_uid"
    t.string   "spotify_data"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_foreign_key "suggestions", "restaurants"
  add_foreign_key "suggestions", "spotify_items"
end
