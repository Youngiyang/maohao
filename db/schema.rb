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

ActiveRecord::Schema.define(version: 20160111163819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "group_id",        default: 1,     null: false
    t.string   "password_digest",                 null: false
    t.boolean  "is_super",        default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
  end

  create_table "app_banners", force: :cascade do |t|
    t.string   "title",                  null: false
    t.string   "image",                  null: false
    t.string   "url",                    null: false
    t.string   "jump_type",              null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "state",      default: 1, null: false
  end

  create_table "auth_codes", force: :cascade do |t|
    t.string   "mobile",                     null: false
    t.string   "code",                       null: false
    t.boolean  "auth_state",                 null: false
    t.integer  "validated_time", default: 0, null: false
    t.datetime "sent_at"
    t.datetime "expire_at",                  null: false
    t.string   "auth_code_type"
  end

  add_index "auth_codes", ["mobile"], name: "index_auth_codes_on_mobile", using: :btree

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.string   "object_type", null: false
    t.integer  "object_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "coupon_items", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.integer  "coupon_id",                      null: false
    t.string   "coupon_sn",                      null: false
    t.integer  "state",             default: 0,  null: false
    t.datetime "used_at"
    t.datetime "expired_at",                     null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "shop_id",                        null: false
    t.string   "shop_name",                      null: false
    t.string   "coupon_name",                    null: false
    t.integer  "coupon_type",                    null: false
    t.integer  "coupon_cheap"
    t.float    "coupon_discount"
    t.datetime "coupon_start_time"
    t.datetime "coupon_end_time"
    t.integer  "coupon_min_amount"
    t.string   "coupon_image",      default: "", null: false
  end

  add_index "coupon_items", ["coupon_id"], name: "index_coupon_items_on_coupon_id", using: :btree
  add_index "coupon_items", ["coupon_sn"], name: "index_coupon_items_on_coupon_sn", unique: true, using: :btree
  add_index "coupon_items", ["user_id"], name: "index_coupon_items_on_user_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.integer  "shop_id",         default: 0,  null: false
    t.string   "name",                         null: false
    t.text     "remark",          default: "", null: false
    t.integer  "cc_type",                      null: false
    t.datetime "start_grab_time"
    t.datetime "end_grab_time"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "period_time"
    t.integer  "cheap"
    t.integer  "min_amount",      default: 0,  null: false
    t.integer  "total",           default: 0,  null: false
    t.integer  "giveout",         default: 0,  null: false
    t.integer  "used",            default: 0,  null: false
    t.integer  "perlimit",        default: 1,  null: false
    t.integer  "quantity",        default: 1,  null: false
    t.integer  "state"
    t.datetime "audited_at"
    t.string   "audit_reason"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "discount"
    t.string   "image",           default: "", null: false
  end

  add_index "coupons", ["end_grab_time"], name: "index_coupons_on_end_grab_time", using: :btree


  create_table "recommended_shops", force: :cascade do |t|
    t.integer  "shop_id",                null: false
    t.string   "image",                  null: false
    t.integer  "state",      default: 1, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "parent_id",  default: 0, null: false
    t.integer  "sort_order", default: 1, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "encoding",               null: false
    t.integer  "depth",                  null: false
  end

  add_index "regions", ["name", "parent_id"], name: "index_regions_on_name_and_parent_id", unique: true, using: :btree
  add_index "regions", ["name"], name: "index_regions_on_name", using: :btree
  add_index "regions", ["parent_id"], name: "index_regions_on_parent_id", using: :btree

  create_table "shop_classes", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "description", default: "",    null: false
    t.string   "icon"
    t.integer  "parent_id",   default: 0,     null: false
    t.integer  "sort_order",  default: 1,     null: false
    t.boolean  "is_hot",      default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shop_evaluations", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.string   "user_nick_name"
    t.integer  "shop_id",                    null: false
    t.integer  "star_grade",     default: 1, null: false
    t.string   "content",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "coupon_item_id",             null: false
  end

  create_table "shops", force: :cascade do |t|
    t.integer   "first_class_id",                                                                               null: false
    t.integer   "second_class_id",                                                              default: 0,     null: false
    t.string    "name",                                                                                         null: false
    t.string    "logo"
    t.json      "images"
    t.integer   "region_id",                                                                                    null: false
    t.string    "address",                                                                                      null: false
    t.geography "location",            limit: {:srid=>4326, :type=>"point", :geographic=>true},                 null: false
    t.string    "telephone",                                                                                    null: false
    t.string    "business_hour_start",                                                                          null: false
    t.string    "business_hour_end",                                                                            null: false
    t.boolean   "business_on_holiday",                                                          default: true,  null: false
    t.float     "star_grade",                                                                   default: 5.0,   null: false
    t.integer   "user_id",                                                                                      null: false
    t.boolean   "is_recommand",                                                                 default: false, null: false
    t.text      "description",                                                                  default: "",    null: false
    t.boolean   "is_own",                                                                       default: false, null: false
    t.text      "notice",                                                                       default: "",    null: false
    t.integer   "state",                                                                                        null: false
    t.datetime  "audited_at"
    t.string    "audit_reason"
    t.datetime  "created_at",                                                                                   null: false
    t.datetime  "updated_at",                                                                                   null: false
    t.integer   "total_star",                                                                   default: 0,     null: false
    t.integer   "evaluation_number",                                                            default: 0,     null: false
    t.integer   "city_id",                                                                      default: 0,     null: false
    t.integer   "coupons_count",                                                                default: 0
  end

  add_index "shops", ["first_class_id"], name: "index_shops_on_first_class_id", using: :btree
  add_index "shops", ["location"], name: "index_shops_on_location", using: :gist
  add_index "shops", ["name"], name: "index_shops_on_name", using: :btree
  add_index "shops", ["second_class_id"], name: "index_shops_on_second_class_id", using: :btree

  create_table "shops_audits", force: :cascade do |t|
    t.integer   "state",                                                                        default: 0
    t.string    "result",                                                                       default: ""
    t.integer   "shop_id"
    t.integer   "first_class_id",                                                                               null: false
    t.integer   "second_class_id",                                                              default: 0,     null: false
    t.string    "name",                                                                                         null: false
    t.string    "logo"
    t.json      "images"
    t.integer   "region_id",                                                                                    null: false
    t.string    "address",                                                                                      null: false
    t.geography "location",            limit: {:srid=>4326, :type=>"point", :geographic=>true},                 null: false
    t.string    "telephone",                                                                                    null: false
    t.string    "business_hour_start",                                                                          null: false
    t.string    "business_hour_end",                                                                            null: false
    t.boolean   "business_on_holiday",                                                          default: true,  null: false
    t.float     "star_grade",                                                                   default: 5.0,   null: false
    t.integer   "user_id",                                                                                      null: false
    t.boolean   "is_recommand",                                                                 default: false, null: false
    t.text      "description",                                                                  default: "",    null: false
    t.boolean   "is_own",                                                                       default: false, null: false
    t.text      "notice",                                                                       default: "",    null: false
    t.string    "audit_reason"
    t.datetime  "created_at",                                                                                   null: false
    t.datetime  "updated_at",                                                                                   null: false
    t.integer   "city_id"
  end

  create_table "user_feedbacks", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nick_name"
    t.string   "avatar"
    t.string   "email"
    t.string   "mobile",                          null: false
    t.string   "password_digest",                 null: false
    t.string   "sex"
    t.date     "birthday"
    t.integer  "level",           default: 1,     null: false
    t.boolean  "is_seller",       default: false, null: false
    t.integer  "credit_value"
    t.string   "real_name"
    t.string   "identify_sn"
    t.datetime "verfied_at"
    t.string   "auth_token"
    t.integer  "state",           default: 1,     null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "residence"
    t.integer  "grab_numbers",    default: 3
    t.datetime "first_grab_time"
    t.string   "remember_digest"
    t.integer  "shops_count",     default: 0
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree

end
