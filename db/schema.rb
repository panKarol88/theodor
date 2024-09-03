# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_20_103403) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "data_crumbs", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "warehouse_id", null: false
    t.vector "embedding", limit: 1536, null: false
    t.index ["warehouse_id"], name: "index_data_crumbs_on_warehouse_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "store_results", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_features_on_name", unique: true
  end

  create_table "features_warehouses", id: false, force: :cascade do |t|
    t.bigint "feature_id", null: false
    t.bigint "warehouse_id", null: false
    t.index ["feature_id"], name: "index_features_warehouses_on_feature_id"
    t.index ["warehouse_id"], name: "index_features_warehouses_on_warehouse_id"
  end

  create_table "prompt_decorators", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "value", null: false
    t.bigint "feature_id", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_prompt_decorators_on_feature_id"
    t.index ["name"], name: "index_prompt_decorators_on_name", unique: true
    t.index ["priority", "feature_id"], name: "index_prompt_decorators_on_priority_and_feature_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_warehouses", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "warehouse_id", null: false
    t.index ["user_id"], name: "index_users_warehouses_on_user_id"
    t.index ["warehouse_id"], name: "index_users_warehouses_on_warehouse_id"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_warehouses_on_name", unique: true
  end

  create_table "workflows", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_workflows_on_name", unique: true
    t.index ["user_id"], name: "index_workflows_on_user_id"
  end

  create_table "workflows_features", force: :cascade do |t|
    t.bigint "workflow_id", null: false
    t.bigint "feature_id", null: false
    t.integer "priority", default: 0, null: false
    t.jsonb "properties", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_workflows_features_on_feature_id"
    t.index ["workflow_id"], name: "index_workflows_features_on_workflow_id"
  end

  add_foreign_key "data_crumbs", "warehouses"
  add_foreign_key "prompt_decorators", "features"
  add_foreign_key "workflows", "users"
  add_foreign_key "workflows_features", "features"
  add_foreign_key "workflows_features", "workflows"
end
