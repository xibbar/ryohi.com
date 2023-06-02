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

ActiveRecord::Schema.define(version: 2023_06_02_003930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodation_charges", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.string "name"
    t.integer "amount"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bridges", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.integer "position"
    t.integer "target_company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "daily_allowances", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.string "name"
    t.integer "one_day_allowance"
    t.integer "accommodation_day_allowance"
    t.integer "return_day_allowance"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "activate_key"
    t.string "email"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense_templates", id: :serial, force: :cascade do |t|
    t.integer "employee_id"
    t.integer "position"
    t.string "section"
    t.boolean "round", default: true, null: false
    t.string "way"
    t.integer "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "company_id"
  end

  create_table "passwords", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "reset_key"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.integer "target_month_id"
    t.integer "trip_date"
    t.integer "days"
    t.string "destination"
    t.string "business"
    t.integer "daily_allowance_amount"
    t.integer "accommodation_charge_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "date"
    t.integer "employee_id"
    t.integer "daily_allowance_id"
    t.integer "accommodation_charge_id"
  end

  create_table "target_months", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.integer "employee_id"
    t.string "employee_name"
    t.integer "year"
    t.integer "month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trip_expenses", id: :serial, force: :cascade do |t|
    t.integer "schedule_id"
    t.string "section"
    t.boolean "round", default: true, null: false
    t.string "way"
    t.integer "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "login", null: false
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.string "name"
    t.string "state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string "login_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "staff_restrict", default: 5, null: false
    t.date "expires_at"
    t.string "prefecture"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

end
