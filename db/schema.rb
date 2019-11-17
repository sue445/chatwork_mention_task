# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_29_142841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "room_id", null: false
    t.string "name", null: false
    t.string "avatar_image_url", null: false
    t.string "access_token", null: false
    t.string "refresh_token", null: false
    t.datetime "access_token_expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "webhook_token"
    t.integer "account_type", default: 0, null: false
    t.datetime "refresh_token_reminded_at"
    t.string "locale", default: "en", null: false
    t.string "time_zone", default: "UTC", null: false
    t.index ["account_id"], name: "index_users_on_account_id", unique: true
  end

end
