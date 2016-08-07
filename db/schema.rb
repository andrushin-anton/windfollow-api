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

ActiveRecord::Schema.define(version: 20160609201729) do

  create_table "api_v1_followers", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "api_v1_messages", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recepient_id", limit: 4
    t.string   "content",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "api_v1_notifications", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "event_type",      limit: 255
    t.string   "content",         limit: 255
    t.integer  "event_object_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "api_v1_report_comments", force: :cascade do |t|
    t.integer  "report_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "api_v1_report_image_comments", force: :cascade do |t|
    t.integer  "report_image_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "content",         limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "api_v1_report_image_likes", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "report_image_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "api_v1_report_images", force: :cascade do |t|
    t.integer  "report_id",          limit: 4
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "api_v1_report_likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "report_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "api_v1_reports", force: :cascade do |t|
    t.integer  "spot_id",    limit: 4
    t.string   "content",    limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "place",      limit: 255
    t.string   "wind",       limit: 255
    t.string   "direction",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "api_v1_sport_users", force: :cascade do |t|
    t.integer  "sport_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "api_v1_sports", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "api_v1_spot_estimates", force: :cascade do |t|
    t.integer  "spot_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "rating",     limit: 4
    t.string   "best_month", limit: 255
    t.string   "wave",       limit: 255
    t.string   "level",      limit: 255
    t.string   "sport",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "api_v1_spots", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "geo_lat",    limit: 255
    t.string   "geo_lon",    limit: 255
    t.string   "rating",     limit: 255
    t.string   "best_month", limit: 255
    t.string   "wave",       limit: 255
    t.string   "level",      limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "country",    limit: 255
    t.string   "city",       limit: 255
    t.string   "sport",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "api_v1_users", force: :cascade do |t|
    t.string   "email",               limit: 255
    t.string   "password",            limit: 255
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.integer  "rating",              limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "about",               limit: 255
    t.date     "birth_date"
    t.string   "gender",              limit: 255
    t.string   "phone",               limit: 255
    t.string   "web_site",            limit: 255
    t.string   "country",             limit: 255
    t.string   "city",                limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "gfs_2_5", id: false, force: :cascade do |t|
    t.datetime "rt",                  null: false
    t.datetime "vt",                  null: false
    t.float    "lat",      limit: 53, null: false
    t.float    "lon",      limit: 53, null: false
    t.float    "HGT_850",  limit: 53
    t.float    "TMP_850",  limit: 53
    t.float    "UGRD_850", limit: 53
    t.float    "VGRD_850", limit: 53
    t.float    "HGT_925",  limit: 53
    t.float    "TMP_925",  limit: 53
    t.float    "UGRD_925", limit: 53
    t.float    "VGRD_925", limit: 53
    t.float    "HGT_0",    limit: 53
    t.float    "TMP_2",    limit: 53
    t.float    "RH_2",     limit: 53
    t.float    "RH_925",   limit: 53
    t.float    "RH_850",   limit: 53
    t.float    "TMAX_2",   limit: 53
    t.float    "TMIN_2",   limit: 53
    t.float    "UGRD_0",   limit: 53
    t.float    "VGRD_0",   limit: 53
    t.float    "APCP_0",   limit: 53
    t.float    "ACPCP_0",  limit: 53
    t.float    "CSNOW_0",  limit: 53
    t.float    "LFTX_0",   limit: 53
    t.float    "CAPE_0",   limit: 53
    t.float    "TCDC_925", limit: 53
    t.float    "TCDC_700", limit: 53
    t.float    "TCDC_500", limit: 53
    t.float    "TCDC_0",   limit: 53
    t.float    "DSWRF_0",  limit: 53
    t.float    "USWRF_0",  limit: 53
    t.float    "PRMSL_0",  limit: 53
    t.float    "GUST_0",   limit: 53
    t.float    "ULWRF_0",  limit: 53
    t.float    "DLWRF_0",  limit: 53
    t.float    "UGRD_10",  limit: 53
    t.float    "U_GWD_0",  limit: 53
    t.float    "TMP_10",   limit: 53
    t.float    "CPRAT_0",  limit: 53
    t.float    "TMP_0",    limit: 53
    t.float    "VGRD_10",  limit: 53
    t.float    "UGRD_1",   limit: 53
    t.float    "VGRD_1",   limit: 53
  end

  create_table "gfs_2_5_innodb", id: false, force: :cascade do |t|
    t.datetime "rt",                  null: false
    t.datetime "vt",                  null: false
    t.float    "lat",      limit: 53, null: false
    t.float    "lon",      limit: 53, null: false
    t.float    "HGT_850",  limit: 53
    t.float    "TMP_850",  limit: 53
    t.float    "UGRD_850", limit: 53
    t.float    "VGRD_850", limit: 53
    t.float    "HGT_925",  limit: 53
    t.float    "TMP_925",  limit: 53
    t.float    "UGRD_925", limit: 53
    t.float    "VGRD_925", limit: 53
    t.float    "HGT_0",    limit: 53
    t.float    "TMP_2",    limit: 53
    t.float    "RH_2",     limit: 53
    t.float    "RH_925",   limit: 53
    t.float    "RH_850",   limit: 53
    t.float    "TMAX_2",   limit: 53
    t.float    "TMIN_2",   limit: 53
    t.float    "UGRD_0",   limit: 53
    t.float    "VGRD_0",   limit: 53
    t.float    "APCP_0",   limit: 53
    t.float    "ACPCP_0",  limit: 53
    t.float    "CSNOW_0",  limit: 53
    t.float    "LFTX_0",   limit: 53
    t.float    "CAPE_0",   limit: 53
    t.float    "TCDC_925", limit: 53
    t.float    "TCDC_700", limit: 53
    t.float    "TCDC_500", limit: 53
    t.float    "TCDC_0",   limit: 53
    t.float    "DSWRF_0",  limit: 53
    t.float    "USWRF_0",  limit: 53
    t.float    "PRMSL_0",  limit: 53
    t.float    "GUST_0",   limit: 53
    t.float    "ULWRF_0",  limit: 53
    t.float    "DLWRF_0",  limit: 53
    t.float    "UGRD_10",  limit: 53
    t.float    "U_GWD_0",  limit: 53
    t.float    "TMP_10",   limit: 53
    t.float    "CPRAT_0",  limit: 53
    t.float    "TMP_0",    limit: 53
    t.float    "VGRD_10",  limit: 53
    t.float    "UGRD_1",   limit: 53
    t.float    "VGRD_1",   limit: 53
  end

  create_table "wgrib2_parameter_mapping", id: false, force: :cascade do |t|
    t.integer "center_id",             limit: 4,   default: 0,  null: false
    t.string  "wgrib_param_name",      limit: 30,  default: "", null: false
    t.string  "wgrib_param_levelname", limit: 100, default: "", null: false
    t.string  "our_name",              limit: 30
    t.string  "our_levelname",         limit: 100
    t.string  "conversion",            limit: 30
    t.integer "val_precision",         limit: 4
  end

end
