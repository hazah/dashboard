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

ActiveRecord::Schema.define(version: 2020_03_28_170114) do

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

  create_table "aggregate_profile_details", force: :cascade do |t|
    t.bigint "aggregate_profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aggregate_profile_id"], name: "index_aggregate_profile_details_on_aggregate_profile_id"
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

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "parent_id"], name: "index_categories_on_name_and_parent_id", unique: true
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "child_profiles_parent_profiles", force: :cascade do |t|
    t.bigint "parent_profile_id", null: false
    t.bigint "child_profile_id", null: false
    t.index ["child_profile_id"], name: "index_child_profiles_parent_profiles_on_child_profile_id"
    t.index ["parent_profile_id"], name: "index_child_profiles_parent_profiles_on_parent_profile_id"
  end

  create_table "contexts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_contexts_on_name", unique: true
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "aggregate_profile_id", null: false
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aggregate_profile_id"], name: "index_conversations_on_aggregate_profile_id"
  end

  create_table "conversations_messages", id: false, force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.bigint "message_id", null: false
  end

  create_table "credentials", force: :cascade do |t|
    t.string "type"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_credentials_on_profile_id"
  end

  create_table "current_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_current_categories_on_category_id"
    t.index ["profile_id"], name: "index_current_categories_on_profile_id"
  end

  create_table "current_category_children", force: :cascade do |t|
    t.bigint "parent_id", null: false
    t.bigint "category_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_current_category_children_on_category_id"
    t.index ["parent_id"], name: "index_current_category_children_on_parent_id"
    t.index ["profile_id"], name: "index_current_category_children_on_profile_id"
  end

  create_table "current_contexts", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["context_id"], name: "index_current_contexts_on_context_id"
    t.index ["profile_id"], name: "index_current_contexts_on_profile_id"
  end

  create_table "current_conversations", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "conversation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_current_conversations_on_conversation_id"
    t.index ["profile_id"], name: "index_current_conversations_on_profile_id"
  end

  create_table "current_network_modes", force: :cascade do |t|
    t.bigint "network_mode_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["network_mode_id"], name: "index_current_network_modes_on_network_mode_id"
    t.index ["profile_id"], name: "index_current_network_modes_on_profile_id"
  end

  create_table "current_profiles", force: :cascade do |t|
    t.bigint "current_profile_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["current_profile_id"], name: "index_current_profiles_on_current_profile_id"
    t.index ["profile_id"], name: "index_current_profiles_on_profile_id"
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

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "network_modes", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
  add_foreign_key "aggregate_profile_details", "profiles", column: "aggregate_profile_id"
  add_foreign_key "basic_profile_details", "emails", column: "email_model_id"
  add_foreign_key "basic_profile_details", "names", column: "name_model_id"
  add_foreign_key "basic_profile_details", "profiles", column: "basic_profile_id"
  add_foreign_key "categories", "categories", column: "parent_id"
  add_foreign_key "child_profiles_parent_profiles", "aggregate_profile_details", column: "parent_profile_id"
  add_foreign_key "child_profiles_parent_profiles", "profiles", column: "child_profile_id"
  add_foreign_key "conversations", "profiles", column: "aggregate_profile_id"
  add_foreign_key "credentials", "profiles"
  add_foreign_key "current_categories", "categories"
  add_foreign_key "current_categories", "profiles"
  add_foreign_key "current_category_children", "categories"
  add_foreign_key "current_category_children", "categories", column: "parent_id"
  add_foreign_key "current_category_children", "profiles"
  add_foreign_key "current_contexts", "contexts"
  add_foreign_key "current_contexts", "profiles"
  add_foreign_key "current_conversations", "conversations"
  add_foreign_key "current_conversations", "profiles"
  add_foreign_key "current_network_modes", "network_modes"
  add_foreign_key "current_network_modes", "profiles"
  add_foreign_key "current_profiles", "profiles"
  add_foreign_key "current_profiles", "profiles", column: "current_profile_id"
  add_foreign_key "human_details", "agents", column: "human_id"
  add_foreign_key "messages", "users"
  add_foreign_key "password_credential_data", "credentials", column: "password_credential_id"
  add_foreign_key "password_credential_data", "passwords", column: "password_model_id"
  add_foreign_key "profiles", "agents"
  add_foreign_key "users", "credentials"
end
