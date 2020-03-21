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

ActiveRecord::Schema.define(version: 2020_03_21_134622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.bigint "email_address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_address_id"], name: "index_agents_on_email_address_id"
  end

  create_table "credentials", force: :cascade do |t|
    t.bigint "email_address_id", null: false
    t.bigint "password_model_id", null: false
    t.bigint "agent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_credentials_on_agent_id"
    t.index ["email_address_id"], name: "index_credentials_on_email_address_id"
    t.index ["password_model_id"], name: "index_credentials_on_password_model_id"
  end

  create_table "current_agents", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_current_agents_on_agent_id"
  end

  create_table "current_locations", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_current_locations_on_location_id"
  end

  create_table "current_natural_guilds", force: :cascade do |t|
    t.bigint "natural_guild_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["natural_guild_id"], name: "index_current_natural_guilds_on_natural_guild_id"
  end

  create_table "current_temperaments", force: :cascade do |t|
    t.bigint "temperament_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["temperament_id"], name: "index_current_temperaments_on_temperament_id"
  end

  create_table "email_addresses", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_email_addresses_on_email", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "raw_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "natural_guilds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "passwords", force: :cascade do |t|
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "temperaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "credential_id", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["credential_id"], name: "index_users_on_credential_id"
  end

  add_foreign_key "agents", "email_addresses"
  add_foreign_key "credentials", "agents"
  add_foreign_key "credentials", "email_addresses"
  add_foreign_key "credentials", "passwords", column: "password_model_id"
  add_foreign_key "current_agents", "agents"
  add_foreign_key "current_locations", "locations"
  add_foreign_key "current_natural_guilds", "natural_guilds"
  add_foreign_key "current_temperaments", "temperaments"
  add_foreign_key "users", "credentials"
end
