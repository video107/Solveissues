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

ActiveRecord::Schema.define(version: 20151015010805) do

  create_table "election_records", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "category",     limit: 255, null: false
    t.string   "onwork_title", limit: 255
    t.string   "electorate",   limit: 255
    t.string   "party",        limit: 255
    t.date     "vote_date"
    t.integer  "result",       limit: 4
    t.date     "period_start"
    t.date     "period_end"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "creator",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "votes_count", limit: 4
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "agent_id",   limit: 4
    t.boolean  "like",       limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "likes", ["agent_id"], name: "index_likes_on_agent_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "fb_image",               limit: 255
    t.string   "fb_uid",                 limit: 255
    t.string   "fb_access_token",        limit: 255
    t.datetime "fb_expires_at"
    t.string   "authentication_token",   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "role",                   limit: 4
    t.string   "country",                limit: 255
    t.string   "photo_file_name",        limit: 255
    t.string   "photo_content_type",     limit: 255
    t.integer  "photo_file_size",        limit: 4
    t.datetime "photo_updated_at"
    t.string   "name",                   limit: 255
    t.text     "description",            limit: 65535
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "issue_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "votes", ["issue_id"], name: "index_votes_on_issue_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
