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

ActiveRecord::Schema.define(version: 20150617154033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.boolean  "can_administer"
    t.boolean  "can_addphotos"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "picture_id"
    t.string   "passcode",    limit: 255
    t.string   "subdomain",   limit: 255
    t.string   "yo_api_key",  limit: 255
    t.string   "yo_username", limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nickname",         limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "comment",          limit: 255
    t.string   "commentable_type", limit: 255
    t.integer  "commentable_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "description",               limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "picture_file_file_name",    limit: 255
    t.string   "picture_file_content_type", limit: 255
    t.integer  "picture_file_file_size"
    t.datetime "picture_file_updated_at"
    t.integer  "image_width_large"
    t.integer  "image_height_large"
    t.integer  "image_width_medium"
    t.integer  "image_height_medium"
    t.string   "latitude",                  limit: 255
    t.string   "longitude",                 limit: 255
    t.datetime "taken_at"
    t.string   "filepicker_url",            limit: 255
  end

  add_index "pictures", ["album_id"], name: "index_pictures_on_album_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "nickname",               limit: 255
    t.datetime "confirmed_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "description",             limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "video_file_file_name",    limit: 255
    t.string   "video_file_content_type", limit: 255
    t.integer  "video_file_file_size"
    t.datetime "video_file_updated_at"
    t.boolean  "encoded",                             default: false
  end

  add_index "videos", ["album_id"], name: "index_videos_on_album_id", using: :btree

end
