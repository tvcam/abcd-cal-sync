# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_10_005010) do
  create_table "calendars", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "google_id", null: false
    t.text "description"
    t.string "summary"
    t.boolean "primary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_calendars_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "calendar_id", null: false
    t.string "google_id"
    t.text "attendees"
    t.text "creator"
    t.datetime "created"
    t.text "description"
    t.text "event_end"
    t.text "event_start"
    t.string "status"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "google_user_id", null: false
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "calendars", "users"
  add_foreign_key "events", "calendars"
end
