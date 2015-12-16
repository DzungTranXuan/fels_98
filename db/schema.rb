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

ActiveRecord::Schema.define(version: 20151209095015) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "type_name",  limit: 255
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "cover_photo", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "followings", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "follower_id",      limit: 4
    t.integer  "followed_user_id", limit: 4
  end

  add_index "followings", ["followed_user_id"], name: "index_followings_on_followed_user_id", using: :btree
  add_index "followings", ["follower_id"], name: "index_followings_on_follower_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.integer  "category_id",         limit: 4
    t.integer  "user_id",             limit: 4
    t.integer  "number_of_questions", limit: 4, default: 20
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "lessons", ["category_id"], name: "index_lessons_on_category_id", using: :btree
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "question_choices", force: :cascade do |t|
    t.integer  "word_id",    limit: 4
    t.string   "text",       limit: 255
    t.boolean  "correct"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "question_choices", ["word_id"], name: "index_question_choices_on_word_id", using: :btree

  create_table "user_answers", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "word_id",            limit: 4
    t.integer  "lesson_id",          limit: 4
    t.integer  "question_choice_id", limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "order",              limit: 4
    t.boolean  "correct",                      default: false
  end

  add_index "user_answers", ["lesson_id"], name: "index_user_answers_on_lesson_id", using: :btree
  add_index "user_answers", ["question_choice_id"], name: "index_user_answers_on_question_choice_id", using: :btree
  add_index "user_answers", ["user_id"], name: "index_user_answers_on_user_id", using: :btree
  add_index "user_answers", ["word_id"], name: "index_user_answers_on_word_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "words", force: :cascade do |t|
    t.integer  "category_id",        limit: 4
    t.string   "text",               limit: 255
    t.string   "meaning",            limit: 255
    t.string   "pronunciation_file", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "words", ["category_id"], name: "index_words_on_category_id", using: :btree

  add_foreign_key "activities", "users"
  add_foreign_key "lessons", "categories"
  add_foreign_key "lessons", "users"
  add_foreign_key "question_choices", "words"
  add_foreign_key "user_answers", "lessons"
  add_foreign_key "user_answers", "question_choices"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_answers", "words"
  add_foreign_key "words", "categories"
end
