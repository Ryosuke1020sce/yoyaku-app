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

ActiveRecord::Schema[7.0].define(version: 2024_12_17_082557) do
  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "calendars", charset: "utf8mb3", force: :cascade do |t|
    t.date "std_date", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_calendars_on_store_id"
  end

  create_table "guests", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "mail"
    t.integer "people_n"
    t.string "tel"
    t.bigint "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_guests_on_reservation_id"
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

  create_table "rsv_numbers", charset: "utf8mb3", force: :cascade do |t|
    t.string "unique_number", null: false
    t.bigint "guest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_rsv_numbers_on_guest_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "calendars", "stores"
  add_foreign_key "guests", "reservations"
  add_foreign_key "reservations", "rsv_groups"
  add_foreign_key "reservations", "stores"
  add_foreign_key "rsv_numbers", "guests"
  add_foreign_key "stores", "users"
end
