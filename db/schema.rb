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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140801191347) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "picture_id"
    t.string   "passcode"
    t.string   "subdomain"
    t.string   "yo_api_key"
    t.string   "yo_username"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "comment"
    t.string   "commentable_type"
    t.integer  "commentable_id"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.boolean  "can_administer"
    t.boolean  "can_addphotos"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "pictures", :force => true do |t|
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "picture_file_file_name"
    t.string   "picture_file_content_type"
    t.integer  "picture_file_file_size"
    t.datetime "picture_file_updated_at"
    t.integer  "image_width_large"
    t.integer  "image_height_large"
    t.integer  "image_width_medium"
    t.integer  "image_height_medium"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "taken_at"
    t.string   "filepicker_url"
  end

  add_index "pictures", ["album_id"], :name => "index_pictures_on_album_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nickname"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "video_file_file_name"
    t.string   "video_file_content_type"
    t.integer  "video_file_file_size"
    t.datetime "video_file_updated_at"
  end

  add_index "videos", ["album_id"], :name => "index_videos_on_album_id"

end
