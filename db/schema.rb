# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20191210172910) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "admin_username",         default: "", null: false
    t.string   "admin_last_name",        default: "", null: false
    t.string   "admin_first_name",       default: "", null: false
    t.string   "admin_phonenumber",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.string   "unconfirmed_email"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  add_index "admins", ["unconfirmed_email"], name: "index_admins_on_unconfirmed_email", unique: true

  create_table "meals", force: :cascade do |t|
    t.string   "meal_name"
    t.integer  "meal_calories"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "dietary_restrictions", default: "", null: false
    t.text     "description",          default: "", null: false
  end

  add_index "meals", ["meal_name"], name: "index_meals_on_meal_name", unique: true

  create_table "orders", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "meal_id"
    t.boolean  "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "student_username",       default: "", null: false
    t.string   "student_last_name",      default: "", null: false
    t.string   "student_first_name",     default: "", null: false
    t.string   "student_phonenumber",    default: "", null: false
    t.string   "dietary_restrictions",   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.string   "unconfirmed_email"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "students", ["confirmation_token"], name: "index_students_on_confirmation_token", unique: true
  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  add_index "students", ["unconfirmed_email"], name: "index_students_on_unconfirmed_email", unique: true

end
