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

ActiveRecord::Schema.define(version: 2020_08_13_155844) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recordings", force: :cascade do |t|
    t.text "file"
    t.integer "sequence_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comments"
    t.integer "likes"
  end

  create_table "recordings_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recording_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.string "name"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sequences", force: :cascade do |t|
    t.text "name"
    t.text "key"
    t.text "scale"
    t.text "data"
    t.integer "user_id"
    t.integer "bpm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.integer "user_id"
    t.text "email"
    t.text "password_digest"
    t.text "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "profile_pic"
    t.boolean "email_verified"
    t.boolean "email_confirmed"
    t.string "confirm_token"
  end

end
