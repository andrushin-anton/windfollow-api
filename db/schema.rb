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

ActiveRecord::Schema.define(version: 20170906214839) do

  create_table "api_v1_alerts", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.float    "distance",                limit: 24
    t.string   "time_alert",              limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "spot_id",                 limit: 4
    t.string   "direction",               limit: 255, default: "--- []\n"
    t.integer  "speed_from",              limit: 4
    t.integer  "speed_to",                limit: 4
    t.datetime "forecast_last_time_sent"
    t.datetime "sensor_last_time_sent"
    t.integer  "sensor_enabled",          limit: 4
    t.integer  "notify_for_days",         limit: 4
  end

  add_index "api_v1_alerts", ["spot_id"], name: "index_api_v1_alerts_on_spot_id", using: :btree
  add_index "api_v1_alerts", ["user_id"], name: "index_api_v1_alerts_on_user_id", using: :btree

  create_table "api_v1_conversations", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_v1_devices", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "token",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "api_v1_favorite_spots", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "spot_id",    limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "closed",     limit: 4, default: 0
  end

  create_table "api_v1_followers", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "api_v1_gfs", id: false, force: :cascade do |t|
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

  create_table "api_v1_messages", force: :cascade do |t|
    t.text     "body",            limit: 65535
    t.integer  "conversation_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.boolean  "read",            limit: 1,     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_v1_messages", ["conversation_id"], name: "index_api_v1_messages_on_conversation_id", using: :btree
  add_index "api_v1_messages", ["user_id"], name: "index_api_v1_messages_on_user_id", using: :btree

  create_table "api_v1_messages_copy", id: false, force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "viewed",       limit: 4,     default: 0
    t.integer  "recepient_id", limit: 4
    t.integer  "sender_id",    limit: 4
  end

  create_table "api_v1_notifications", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "event_type",      limit: 255
    t.text     "content",         limit: 65535
    t.integer  "event_object_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "api_v1_report_comments", force: :cascade do |t|
    t.integer  "report_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
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

  create_table "api_v1_report_views_counts", force: :cascade do |t|
    t.integer  "report_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "api_v1_report_views_counts", ["report_id"], name: "index_api_v1_report_views_counts_on_report_id", using: :btree

  create_table "api_v1_reports", force: :cascade do |t|
    t.integer  "spot_id",    limit: 4
    t.string   "content",    limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "place",      limit: 255
    t.string   "wind",       limit: 255
    t.string   "direction",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "geo_lat",    limit: 255
    t.string   "geo_lon",    limit: 255
  end

  create_table "api_v1_sensor_data", force: :cascade do |t|
    t.integer  "sensor_id",  limit: 4
    t.string   "wind",       limit: 255
    t.string   "mid",        limit: 255
    t.string   "lwind",      limit: 255
    t.string   "dir",        limit: 255
    t.string   "temp1",      limit: 255
    t.string   "temp2",      limit: 255
    t.string   "h",          limit: 255
    t.string   "p",          limit: 255
    t.string   "dew_point",  limit: 255
    t.string   "alarm",      limit: 255
    t.string   "u_out",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "api_v1_sensor_data", ["sensor_id"], name: "index_api_v1_sensor_data_on_sensor_id", using: :btree

  create_table "api_v1_sensors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.string   "geo_lat",    limit: 255
    t.string   "geo_lon",    limit: 255
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
    t.integer  "active",     limit: 4
    t.integer  "meteo",      limit: 4
  end

  create_table "api_v1_supports", force: :cascade do |t|
    t.text     "message",    limit: 65535
    t.text     "details",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "api_v1_user_activities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "api_v1_user_activities", ["updated_at"], name: "index_api_v1_user_activities_on_updated_at", using: :btree
  add_index "api_v1_user_activities", ["user_id"], name: "index_api_v1_user_activities_on_user_id", using: :btree

  create_table "api_v1_user_spots", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "spot_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "api_v1_user_spots", ["user_id"], name: "index_api_v1_user_spots_on_user_id", using: :btree

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
    t.string   "wind",                limit: 255
    t.string   "temp",                limit: 255
    t.string   "geo_lat",             limit: 255
    t.string   "geo_lon",             limit: 255
    t.string   "timezone",            limit: 255
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

  create_table "groups", force: :cascade do |t|
    t.string "name",        limit: 20,  null: false
    t.string "description", limit: 100, null: false
  end

  create_table "login_attempts", force: :cascade do |t|
    t.string  "ip_address", limit: 15,  null: false
    t.string  "login",      limit: 100, null: false
    t.integer "time",       limit: 4
  end

  create_table "rails_push_notifications_apns_apps", force: :cascade do |t|
    t.text     "apns_dev_cert",  limit: 65535
    t.text     "apns_prod_cert", limit: 65535
    t.boolean  "sandbox_mode",   limit: 1
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "rails_push_notifications_gcm_apps", force: :cascade do |t|
    t.string   "gcm_key",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rails_push_notifications_mpns_apps", force: :cascade do |t|
    t.text     "cert",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "rails_push_notifications_notifications", force: :cascade do |t|
    t.text     "destinations", limit: 65535
    t.integer  "app_id",       limit: 4
    t.string   "app_type",     limit: 255
    t.text     "data",         limit: 65535
    t.text     "results",      limit: 65535
    t.integer  "success",      limit: 4
    t.integer  "failed",       limit: 4
    t.boolean  "sent",         limit: 1,     default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "rails_push_notifications_notifications", ["app_id", "app_type", "sent"], name: "app_and_sent_index_on_rails_push_notifications", using: :btree

  create_table "redirects", force: :cascade do |t|
    t.string "from", limit: 255
    t.string "to",   limit: 255
  end

  create_table "seo", force: :cascade do |t|
    t.string "url",              limit: 255
    t.string "title",            limit: 255
    t.text   "seo_text",         limit: 65535
    t.text   "meta_keywords",    limit: 65535
    t.text   "meta_description", limit: 65535
  end

  create_table "settings", force: :cascade do |t|
    t.string "name",  limit: 255
    t.text   "value", limit: 4294967295
  end

  create_table "spots", force: :cascade do |t|
    t.integer "old_id",           limit: 4,     default: 0,            null: false
    t.string  "table",            limit: 50,                           null: false
    t.integer "user_id",          limit: 4,     default: 0,            null: false
    t.string  "ru_name",          limit: 255,   default: "",           null: false
    t.string  "en_name",          limit: 255,   default: "",           null: false
    t.string  "bwind",            limit: 20,    default: "all",        null: false
    t.integer "country_id",       limit: 4,     default: 0,            null: false
    t.integer "region_id",        limit: 4,     default: 0,            null: false
    t.integer "city_id",          limit: 4,                            null: false
    t.string  "phone",            limit: 100,                          null: false
    t.integer "position",         limit: 4,                            null: false
    t.integer "status",           limit: 4,     default: 1,            null: false
    t.integer "is_meteo",         limit: 4,     default: 0,            null: false
    t.integer "count_alboms",     limit: 4,     default: 0,            null: false
    t.integer "count_photos",     limit: 4,     default: 0,            null: false
    t.integer "count_videos",     limit: 4,     default: 0,            null: false
    t.integer "count_users",      limit: 4,     default: 0,            null: false
    t.integer "count_schools",    limit: 4,     default: 0,            null: false
    t.string  "avatar",           limit: 255,   default: "_none_.jpg", null: false
    t.float   "geo_lat",          limit: 24,                           null: false
    t.float   "geo_long",         limit: 24,                           null: false
    t.integer "zoom",             limit: 4,     default: 8,            null: false
    t.string  "gmt",              limit: 5,     default: "0",          null: false
    t.float   "coefficient",      limit: 24,    default: 1.0,          null: false
    t.string  "windguru",         limit: 255,                          null: false
    t.text    "windfinder",       limit: 65535,                        null: false
    t.integer "is_pro",           limit: 4,     default: 0,            null: false
    t.integer "time_limit",       limit: 4,     default: 0,            null: false
    t.integer "hide_statistic",   limit: 4,     default: 0,            null: false
    t.text    "price",            limit: 65535,                        null: false
    t.integer "radius",           limit: 4,     default: 500,          null: false
    t.integer "created_from_app", limit: 4,     default: 0,            null: false
    t.integer "new_rating",       limit: 4
    t.string  "new_sport",        limit: 255
    t.string  "new_user_lvl",     limit: 255
    t.string  "new_wave_type",    limit: 255
    t.string  "new_best_month",   limit: 255
  end

  create_table "spots_country", force: :cascade do |t|
    t.string "name", limit: 128, default: "", null: false
  end

  create_table "spots_photos", force: :cascade do |t|
    t.integer "user_id",     limit: 4,   default: 0, null: false
    t.integer "spot_id",     limit: 4,   default: 0, null: false
    t.string  "img",         limit: 100,             null: false
    t.integer "created",     limit: 4,               null: false
    t.integer "count_likes", limit: 4,   default: 0, null: false
    t.integer "is_new",      limit: 4,   default: 0, null: false
  end

  add_index "spots_photos", ["spot_id"], name: "spot_id", using: :btree
  add_index "spots_photos", ["user_id"], name: "user_id", using: :btree

  create_table "spots_region", force: :cascade do |t|
    t.integer "country_id", limit: 4,  default: 0,  null: false
    t.string  "name",       limit: 64, default: "", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string  "ip_address",              limit: 15,  null: false
    t.string  "username",                limit: 100
    t.string  "password",                limit: 255, null: false
    t.string  "salt",                    limit: 255
    t.string  "email",                   limit: 100, null: false
    t.string  "activation_code",         limit: 40
    t.string  "forgotten_password_code", limit: 40
    t.integer "forgotten_password_time", limit: 4
    t.string  "remember_code",           limit: 40
    t.integer "created_on",              limit: 4,   null: false
    t.integer "last_login",              limit: 4
    t.boolean "active",                  limit: 1
    t.string  "first_name",              limit: 50
    t.string  "last_name",               limit: 50
    t.string  "company",                 limit: 100
    t.string  "phone",                   limit: 20
  end

  create_table "users_groups", force: :cascade do |t|
    t.integer "user_id",  limit: 4, null: false
    t.integer "group_id", limit: 3, null: false
  end

  add_index "users_groups", ["group_id"], name: "fk_users_groups_groups1_idx", using: :btree
  add_index "users_groups", ["user_id", "group_id"], name: "uc_users_groups", unique: true, using: :btree
  add_index "users_groups", ["user_id"], name: "fk_users_groups_users1_idx", using: :btree

  create_table "wgrib2_parameter_mapping", id: false, force: :cascade do |t|
    t.integer "center_id",             limit: 4,   default: 0,  null: false
    t.string  "wgrib_param_name",      limit: 30,  default: "", null: false
    t.string  "wgrib_param_levelname", limit: 100, default: "", null: false
    t.string  "our_name",              limit: 30
    t.string  "our_levelname",         limit: 100
    t.string  "conversion",            limit: 30
    t.integer "val_precision",         limit: 4
  end

  add_foreign_key "users_groups", "groups", name: "fk_users_groups_groups1", on_delete: :cascade
  add_foreign_key "users_groups", "users", name: "fk_users_groups_users1", on_delete: :cascade
end
