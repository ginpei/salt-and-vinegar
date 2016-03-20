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

ActiveRecord::Schema.define(version: 20160320015604) do

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "currency"
  end

  add_index "books", ["token"], name: "index_books_on_token", unique: true

  create_table "items", force: :cascade do |t|
    t.integer  "paper_id",   null: false
    t.string   "name",       null: false
    t.string   "quantity"
    t.string   "orderer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "price"
    t.string   "unit"
    t.text     "comment"
  end

  add_index "items", ["paper_id"], name: "index_items_on_paper_id"

  create_table "papers", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "book_id"
    t.text     "description"
  end

end
