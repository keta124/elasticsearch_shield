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

ActiveRecord::Schema.define(version: 20180104163101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "coin_calculators", force: :cascade do |t|
    t.string "coin", null: false
    t.decimal "difficulty", precision: 30, scale: 10, null: false
    t.decimal "block_reward", precision: 20, scale: 10, null: false
    t.integer "type_algorithm", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_notified_at"
    t.integer "source", default: 0, null: false
    t.string "coin"
    t.string "currency"
    t.decimal "value", precision: 20, scale: 10
    t.integer "operation"
    t.boolean "active", default: true
    t.index ["source"], name: "index_conditions_on_source"
    t.index ["user_id"], name: "index_conditions_on_user_id"
  end

  create_table "exchange_coins", force: :cascade do |t|
    t.string "market"
    t.string "coin"
    t.decimal "price_btc", precision: 20, scale: 10
    t.decimal "price_usd", precision: 20, scale: 10
    t.decimal "price_vnd", precision: 20, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_usdt", precision: 20, scale: 10
    t.index ["market", "coin"], name: "index_exchange_coins_on_market_and_coin"
  end

  create_table "exchange_usd_vnds", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sms_logs", force: :cascade do |t|
    t.string "provider"
    t.string "status"
    t.string "to_number"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_sms_logs_on_user_id"
  end

  create_table "telco_card_charging_logs", force: :cascade do |t|
    t.string "provider"
    t.integer "code"
    t.string "msg"
    t.integer "info_card"
    t.integer "transaction_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.integer "credits"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
