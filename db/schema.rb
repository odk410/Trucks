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

ActiveRecord::Schema.define(version: 2018_05_29_072006) do

  create_table "accounts", force: :cascade do |t|
    t.string "acc_num"
    t.string "master_type"
    t.integer "master_id"
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["master_type", "master_id"], name: "index_accounts_on_master_type_and_master_id"
  end

  create_table "celeb_wikis", force: :cascade do |t|
    t.integer "celebrity_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["celebrity_id"], name: "index_celeb_wikis_on_celebrity_id"
  end

  create_table "celebrities", force: :cascade do |t|
    t.string "name", null: false
    t.integer "company_id"
    t.integer "group_id"
    t.string "category", default: "", null: false
    t.string "color", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_celebrities_on_company_id"
    t.index ["group_id"], name: "index_celebrities_on_group_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.integer "num_member"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_groups_on_company_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "imp_uid"
    t.string "pg_provider"
    t.integer "amount"
    t.string "name"
    t.string "pay_method"
    t.string "status"
    t.string "merchant_uid"
    t.integer "user_id"
    t.string "cancel_reason"
    t.integer "cancelled_at"
    t.integer "cancel_amount"
    t.integer "paid_at"
    t.string "fail_reason"
    t.integer "failed_at"
    t.string "pg_tid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "account_id"
    t.integer "amount"
    t.integer "balance"
    t.boolean "send"
    t.boolean "receive"
    t.string "to_acc_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tel", limit: 15, default: "", null: false
    t.string "name", limit: 20, default: ""
    t.text "addr", limit: 100, default: ""
    t.string "postcode", limit: 15, default: ""
    t.string "profile_img"
    t.boolean "verified", default: false
    t.boolean "celeb_verified", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wiki_pic_uploads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wiki_pics"
  end

end
