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

ActiveRecord::Schema.define(version: 2022_01_22_125647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "links", id: false, force: :cascade do |t|
    t.bigint "list_id"
    t.bigint "user_id"
    t.index ["list_id", "user_id"], name: "index_links_on_list_id_and_user_id", unique: true
    t.index ["list_id"], name: "index_links_on_list_id"
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "share_hash"
  end

  create_table "tags", force: :cascade do |t|
    t.string "text"
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "text"
    t.boolean "done"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "day"
    t.string "tags", default: [], array: true
    t.bigint "list_id", null: false
    t.index ["list_id"], name: "index_tasks_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "github_id"
    t.string "google_id"
  end

  add_foreign_key "links", "lists"
  add_foreign_key "links", "users"
  add_foreign_key "tags", "users"
  add_foreign_key "tasks", "lists"
end
