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

ActiveRecord::Schema.define(version: 20150820221632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_games", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "developer_games", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "developer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "developers", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "developers", ["slug"], name: "index_developers_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "steam_appid"
    t.string   "data"
    t.string   "title",                null: false
    t.string   "slug"
    t.integer  "cached_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "release_date"
    t.integer  "cached_reviews_total"
    t.string   "cached_rank"
    t.string   "dlc"
    t.string   "detailed_description"
    t.string   "platforms"
    t.string   "header_image"
    t.string   "website"
    t.string   "background_image"
  end

  add_index "games", ["slug"], name: "index_games_on_slug", unique: true, using: :btree
  add_index "games", ["title"], name: "index_games_on_title", using: :btree

  create_table "genre_games", force: :cascade do |t|
    t.integer  "genre_id"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platform_games", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "platform_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "platforms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publisher_games", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "publisher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "publishers", ["slug"], name: "index_publishers_on_slug", unique: true, using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "framerate"
    t.integer  "resolution"
    t.integer  "optimization"
    t.integer  "mods"
    t.integer  "servers"
    t.integer  "dlc"
    t.integer  "bugs"
    t.integer  "settings"
    t.integer  "controls"
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "review"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "ratings", ["cached_votes_down"], name: "index_ratings_on_cached_votes_down", using: :btree
  add_index "ratings", ["cached_votes_score"], name: "index_ratings_on_cached_votes_score", using: :btree
  add_index "ratings", ["cached_votes_total"], name: "index_ratings_on_cached_votes_total", using: :btree
  add_index "ratings", ["cached_votes_up"], name: "index_ratings_on_cached_votes_up", using: :btree
  add_index "ratings", ["cached_weighted_average"], name: "index_ratings_on_cached_weighted_average", using: :btree
  add_index "ratings", ["cached_weighted_score"], name: "index_ratings_on_cached_weighted_score", using: :btree
  add_index "ratings", ["cached_weighted_total"], name: "index_ratings_on_cached_weighted_total", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",          default: 0
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "fps"
    t.integer  "resolution"
    t.integer  "multi_monitor"
    t.integer  "optimization"
    t.integer  "bugs"
    t.integer  "cosmetic_modding"
    t.integer  "functionality_modding"
    t.integer  "modding_tools"
    t.integer  "level_editors"
    t.integer  "server_stability"
    t.integer  "dedicated_servers"
    t.integer  "lan_support"
    t.integer  "day_1_dlc"
    t.integer  "dlc_quality"
    t.integer  "video_options"
    t.integer  "key_remapping"
    t.integer  "mouse_sensitivity_adjustment"
    t.integer  "vr_support"
    t.integer  "subtitle_support"
    t.integer  "launcher_drm"
    t.integer  "limited_activations"
    t.integer  "drm_free"
    t.integer  "disc_check"
    t.integer  "always_on_drm"
    t.integer  "drm_servers_off"
    t.integer  "opinion"
    t.string   "review"
    t.integer  "user_id",                                    null: false
    t.integer  "game_id",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "cached_votes_total",           default: 0
    t.integer  "cached_votes_score",           default: 0
    t.integer  "cached_votes_up",              default: 0
    t.integer  "cached_votes_down",            default: 0
    t.integer  "cached_weighted_score",        default: 0
    t.integer  "cached_weighted_total",        default: 0
    t.float    "cached_weighted_average",      default: 0.0
    t.float    "cached_rank"
    t.float    "cached_score"
    t.datetime "deleted_at"
    t.integer  "deleter_id"
  end

  add_index "reviews", ["cached_votes_down"], name: "index_reviews_on_cached_votes_down", using: :btree
  add_index "reviews", ["cached_votes_score"], name: "index_reviews_on_cached_votes_score", using: :btree
  add_index "reviews", ["cached_votes_total"], name: "index_reviews_on_cached_votes_total", using: :btree
  add_index "reviews", ["cached_votes_up"], name: "index_reviews_on_cached_votes_up", using: :btree
  add_index "reviews", ["cached_weighted_average"], name: "index_reviews_on_cached_weighted_average", using: :btree
  add_index "reviews", ["cached_weighted_score"], name: "index_reviews_on_cached_weighted_score", using: :btree
  add_index "reviews", ["cached_weighted_total"], name: "index_reviews_on_cached_weighted_total", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "admin",                  default: 0
    t.string   "username"
    t.boolean  "banned",                 default: false
    t.integer  "banner_id"
    t.string   "slug"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
