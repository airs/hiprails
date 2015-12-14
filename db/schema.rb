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

ActiveRecord::Schema.define(version: 20151214152600) do

  create_table "hips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hips", ["room_id"], name: "index_hips_on_room_id"
  add_index "hips", ["user_id"], name: "index_hips_on_user_id"

  create_table "installations", force: :cascade do |t|
    t.string   "oauth_id"
    t.string   "capabilities_url"
    t.integer  "room_id"
    t.integer  "group_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "installations", ["oauth_id"], name: "index_installations_on_oauth_id"

  create_table "oauth_tokens", force: :cascade do |t|
    t.integer  "installation_id"
    t.string   "access_token"
    t.integer  "expires_in"
    t.integer  "group_id"
    t.string   "group_name"
    t.string   "scope"
    t.string   "token_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "oauth_tokens", ["installation_id"], name: "index_oauth_tokens_on_installation_id"

  create_table "rooms", force: :cascade do |t|
    t.integer  "installation_id"
    t.integer  "hipchat_id"
    t.boolean  "archived"
    t.string   "name"
    t.string   "privacy"
    t.string   "version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "rooms", ["installation_id"], name: "index_rooms_on_installation_id"

  create_table "users", force: :cascade do |t|
    t.integer  "installation_id"
    t.integer  "hipchat_id"
    t.string   "mention_name"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["hipchat_id"], name: "index_users_on_hipchat_id"
  add_index "users", ["installation_id"], name: "index_users_on_installation_id"

end
