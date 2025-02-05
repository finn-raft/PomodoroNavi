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

ActiveRecord::Schema[7.1].define(version: 2025_02_05_211130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "navi_characters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "first_person_pronoun"
    t.string "second_person_pronoun"
    t.text "description"
    t.string "icon_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_navi_characters_on_user_id"
  end

  create_table "pomodoro_settings", force: :cascade do |t|
    t.integer "work_duration", default: 25, null: false
    t.integer "short_break_duration", default: 5, null: false
    t.integer "long_break_duration", default: 15, null: false
    t.integer "long_break_cycle", default: 4, null: false
    t.boolean "auto_start_work", default: true, null: false
    t.boolean "auto_start_break", default: true, null: false
    t.boolean "alarm_on", default: true, null: false
    t.string "background_color", default: "#419DC4", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "header_footer_color", default: "#0073e6", null: false
    t.index ["user_id"], name: "index_pomodoro_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.text "profile"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "navi_characters", "users"
  add_foreign_key "pomodoro_settings", "users"
end
