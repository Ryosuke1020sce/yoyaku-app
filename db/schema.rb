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

ActiveRecord::Schema[7.0].define(version: 2024_12_16_080219) do
  create_table "calendars", charset: "utf8mb3", force: :cascade do |t|
    t.date "std_date", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_calendars_on_store_id"
  end

  create_table "reservations", charset: "utf8mb3", force: :cascade do |t|
    t.date "rsv_date", null: false
    t.integer "rsv_n", null: false
    t.integer "rsv_time_id", null: false
    t.string "explain"
    t.integer "service_type_id", null: false
    t.integer "upper_people_n"
    t.integer "fee"
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rsv_group_id"
    t.index ["rsv_group_id"], name: "index_reservations_on_rsv_group_id"
    t.index ["store_id"], name: "index_reservations_on_store_id"
  end

  create_table "rsv_groups", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_id", null: false
    t.index ["calendar_id"], name: "index_rsv_groups_on_calendar_id"
  end

  create_table "stores", charset: "utf8mb3", force: :cascade do |t|
    t.string "store_name", null: false
    t.text "store_guide", null: false
    t.string "store_address", null: false
    t.string "store_tel", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "admin_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "calendars", "stores"
  add_foreign_key "reservations", "rsv_groups"
  add_foreign_key "reservations", "stores"
  add_foreign_key "stores", "users"
end
