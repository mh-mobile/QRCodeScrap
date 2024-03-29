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

ActiveRecord::Schema.define(version: 20180830083243) do

  create_table "gen_type_maps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "qrcode_id"
    t.index ["qrcode_id"], name: "index_gen_type_maps_on_qrcode_id"
  end

  create_table "gen_type_urls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "url"
    t.bigint "qrcode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qrcode_id"], name: "index_gen_type_urls_on_qrcode_id"
  end

  create_table "mylists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "qrcode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qrcode_id"], name: "index_mylists_on_qrcode_id"
    t.index ["user_id", "qrcode_id"], name: "index_mylists_on_user_id_and_qrcode_id", unique: true
    t.index ["user_id"], name: "index_mylists_on_user_id"
  end

  create_table "qrcodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.integer "gen_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qrcode_uuid", null: false
    t.text "base64img", null: false
    t.boolean "published", default: false
    t.index ["user_id"], name: "index_qrcodes_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "gen_type_maps", "qrcodes"
  add_foreign_key "gen_type_urls", "qrcodes"
  add_foreign_key "mylists", "qrcodes"
  add_foreign_key "mylists", "users"
  add_foreign_key "qrcodes", "users"
end
