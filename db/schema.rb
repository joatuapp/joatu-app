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

ActiveRecord::Schema.define(version: 20140625154831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "uuid-ossp"

  create_table "communities", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name",       limit: 128
    t.spatial  "location",   limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "communities", ["location"], :name => "index_communities_on_location", :spatial => true

  create_table "offer_categories", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "offers", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "offer_category_id"
    t.string   "title",             limit: 128
    t.string   "summary"
    t.text     "description"
    t.spatial  "location",          limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "address1",          limit: 128
    t.string   "address2",          limit: 128
    t.string   "postal_code",       limit: 32
    t.string   "neighbourhood",     limit: 128
    t.string   "city",              limit: 128
    t.string   "province",          limit: 128
    t.string   "country",           limit: 128
    t.string   "timeframe",         limit: 128
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "offers", ["offer_category_id"], :name => "index_offers_on_offer_category_id"
  add_index "offers", ["user_id"], :name => "index_offers_on_user_id"

  create_table "user_details", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "primary_community_id"
    t.string   "given_name",           limit: 128
    t.string   "surname",              limit: 128
    t.date     "birth_date"
    t.string   "sex",                  limit: 32
    t.spatial  "current_location",     limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "postal_code",          limit: 32
    t.string   "neighbourhood",        limit: 128
    t.string   "city",                 limit: 128
    t.string   "province",             limit: 128
    t.string   "country",              limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_details", ["current_location"], :name => "index_user_details_on_current_location", :spatial => true
  add_index "user_details", ["primary_community_id"], :name => "index_user_details_on_primary_community_id"
  add_index "user_details", ["user_id"], :name => "index_user_details_on_user_id"

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "username",               limit: 64, default: "",    null: false
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "authentication_token"
    t.boolean  "is_admin",                          default: false, null: false
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
