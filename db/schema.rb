# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_25_020406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "agents", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "basic_profile_details", force: :cascade do |t|
    t.bigint "basic_profile_id", null: false
    t.bigint "name_model_id", null: false
    t.bigint "email_model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["basic_profile_id"], name: "index_basic_profile_details_on_basic_profile_id"
    t.index ["email_model_id"], name: "index_basic_profile_details_on_email_model_id"
    t.index ["name_model_id"], name: "index_basic_profile_details_on_name_model_id"
  end

  create_table "concern_areas", force: :cascade do |t|
    t.bigint "natural_guild_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_concern_areas_on_name", unique: true
    t.index ["natural_guild_id"], name: "index_concern_areas_on_natural_guild_id"
  end

  create_table "credentials", force: :cascade do |t|
    t.string "type"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_credentials_on_profile_id"
  end

  create_table "current_basic_profiles", force: :cascade do |t|
    t.bigint "basic_profile_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["basic_profile_id"], name: "index_current_basic_profiles_on_basic_profile_id"
    t.index ["profile_id"], name: "index_current_basic_profiles_on_profile_id"
  end

  create_table "current_concern_areas", force: :cascade do |t|
    t.bigint "concern_area_id", null: false
    t.bigint "profile_id", null: false
    t.bigint "natural_guild_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["concern_area_id"], name: "index_current_concern_areas_on_concern_area_id"
    t.index ["natural_guild_id"], name: "index_current_concern_areas_on_natural_guild_id"
    t.index ["profile_id"], name: "index_current_concern_areas_on_profile_id"
  end

  create_table "current_locations", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_current_locations_on_location_id"
    t.index ["profile_id"], name: "index_current_locations_on_profile_id"
  end

  create_table "current_natural_guilds", force: :cascade do |t|
    t.bigint "natural_guild_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["natural_guild_id"], name: "index_current_natural_guilds_on_natural_guild_id"
    t.index ["profile_id"], name: "index_current_natural_guilds_on_profile_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "human_details", force: :cascade do |t|
    t.bigint "human_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["human_id"], name: "index_human_details_on_human_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "natural_guilds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_natural_guilds_on_name", unique: true
  end

  create_table "password_credential_data", force: :cascade do |t|
    t.bigint "password_credential_id", null: false
    t.bigint "password_model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["password_credential_id"], name: "index_password_credential_data_on_password_credential_id"
    t.index ["password_model_id"], name: "index_password_credential_data_on_password_model_id"
  end

  create_table "passwords", force: :cascade do |t|
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "type"
    t.bigint "agent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_profiles_on_agent_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "credential_id", null: false
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["credential_id"], name: "index_users_on_credential_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "basic_profile_details", "emails", column: "email_model_id"
  add_foreign_key "basic_profile_details", "names", column: "name_model_id"
  add_foreign_key "basic_profile_details", "profiles", column: "basic_profile_id"
  add_foreign_key "concern_areas", "natural_guilds"
  add_foreign_key "credentials", "profiles"
  add_foreign_key "current_basic_profiles", "profiles"
  add_foreign_key "current_basic_profiles", "profiles", column: "basic_profile_id"
  add_foreign_key "current_concern_areas", "concern_areas"
  add_foreign_key "current_concern_areas", "natural_guilds"
  add_foreign_key "current_concern_areas", "profiles"
  add_foreign_key "current_locations", "locations"
  add_foreign_key "current_locations", "profiles"
  add_foreign_key "current_natural_guilds", "natural_guilds"
  add_foreign_key "current_natural_guilds", "profiles"
  add_foreign_key "human_details", "agents", column: "human_id"
  add_foreign_key "password_credential_data", "credentials", column: "password_credential_id"
  add_foreign_key "password_credential_data", "passwords", column: "password_model_id"
  add_foreign_key "profiles", "agents"
  add_foreign_key "users", "credentials"
end
