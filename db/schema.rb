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

ActiveRecord::Schema[7.0].define(version: 2024_05_01_101908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachment_builds", force: :cascade do |t|
    t.integer "attachmentId"
    t.integer "buildId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachment_machines", force: :cascade do |t|
    t.integer "attachmentId"
    t.integer "machineId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.binary "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "createdBy"
    t.integer "modifiedBy"
  end

  create_table "build_parameters", force: :cascade do |t|
    t.integer "buildId"
    t.integer "machineId"
    t.integer "parameterId"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "build_projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "builds", force: :cascade do |t|
    t.integer "materialId"
    t.integer "machineId"
    t.integer "projectId"
    t.string "name"
    t.string "comments"
    t.float "avgUTS"
    t.float "avgModules"
    t.float "avgEaB"
    t.integer "createdBy"
    t.integer "modifiedBy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed"
    t.binary "tensile_raw_data"
  end

  create_table "cads", force: :cascade do |t|
    t.string "name"
    t.string "file_type"
    t.boolean "archived"
    t.binary "file"
    t.integer "createdBy"
    t.integer "modifiedBy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "machineId"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "group_builds", force: :cascade do |t|
    t.integer "groupId"
    t.integer "buildId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_cads", force: :cascade do |t|
    t.integer "groupId"
    t.integer "cadId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_machines", force: :cascade do |t|
    t.integer "groupId"
    t.integer "machineId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_materials", force: :cascade do |t|
    t.integer "groupId"
    t.integer "materialId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "groupId"
    t.integer "userId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machine_parameters", force: :cascade do |t|
    t.integer "machineId"
    t.integer "parameterId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "archived"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "createdBy"
    t.integer "modifiedBy"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "quantity"
    t.string "material_type"
    t.boolean "archived"
    t.float "meltingOnset"
    t.float "crystallisationOnset"
    t.binary "MSDS"
    t.binary "CoSHH"
    t.binary "DSC"
    t.binary "FT4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "createdBy"
    t.integer "modifiedBy"
    t.string "location"
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cas_ticket"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.string "account_type"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "attachment_builds", "attachments", column: "attachmentId"
  add_foreign_key "attachment_builds", "builds", column: "buildId"
  add_foreign_key "attachment_machines", "attachments", column: "attachmentId"
  add_foreign_key "attachment_machines", "machines", column: "machineId"
  add_foreign_key "attachments", "users", column: "createdBy"
  add_foreign_key "attachments", "users", column: "modifiedBy"
  add_foreign_key "build_parameters", "builds", column: "buildId"
  add_foreign_key "build_parameters", "machines", column: "machineId"
  add_foreign_key "build_parameters", "parameters", column: "parameterId"
  add_foreign_key "builds", "build_projects", column: "projectId"
  add_foreign_key "builds", "machines", column: "machineId"
  add_foreign_key "builds", "materials", column: "materialId"
  add_foreign_key "builds", "users", column: "createdBy"
  add_foreign_key "builds", "users", column: "modifiedBy"
  add_foreign_key "cads", "machines", column: "machineId"
  add_foreign_key "cads", "users", column: "createdBy"
  add_foreign_key "cads", "users", column: "modifiedBy"
  add_foreign_key "group_builds", "builds", column: "buildId"
  add_foreign_key "group_builds", "groups", column: "groupId"
  add_foreign_key "group_cads", "cads", column: "cadId"
  add_foreign_key "group_cads", "groups", column: "groupId"
  add_foreign_key "group_machines", "groups", column: "groupId"
  add_foreign_key "group_machines", "machines", column: "machineId"
  add_foreign_key "group_materials", "groups", column: "groupId"
  add_foreign_key "group_materials", "materials", column: "materialId"
  add_foreign_key "group_users", "groups", column: "groupId"
  add_foreign_key "group_users", "users", column: "userId"
  add_foreign_key "machine_parameters", "machines", column: "machineId"
  add_foreign_key "machine_parameters", "parameters", column: "parameterId"
  add_foreign_key "machines", "users", column: "createdBy"
  add_foreign_key "machines", "users", column: "modifiedBy"
  add_foreign_key "materials", "users", column: "createdBy"
  add_foreign_key "materials", "users", column: "modifiedBy"
end
