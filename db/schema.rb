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

ActiveRecord::Schema.define(version: 20140106054806) do

  create_table "labdesks", force: true do |t|
    t.string   "lab_number"
    t.string   "lab_type"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labdesks", ["id"], name: "index_labdesks_on_id", using: :btree
  add_index "labdesks", ["lab_number"], name: "index_labdesks_on_lab_number", using: :btree
  add_index "labdesks", ["lab_type"], name: "index_labdesks_on_lab_type", using: :btree
  add_index "labdesks", ["student_id"], name: "index_labdesks_on_student_id", using: :btree

  create_table "lockers", force: true do |t|
    t.string   "locker_number"
    t.string   "compartment"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lockers", ["compartment"], name: "index_lockers_on_compartment", using: :btree
  add_index "lockers", ["id"], name: "index_lockers_on_id", using: :btree
  add_index "lockers", ["locker_number"], name: "index_lockers_on_locker_number", using: :btree
  add_index "lockers", ["teacher_id"], name: "index_lockers_on_teacher_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "filename"
    t.text     "descirption"
    t.string   "file_type"
    t.string   "photographable_type"
    t.integer  "photographable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["id"], name: "index_photos_on_id", using: :btree
  add_index "photos", ["photographable_type", "photographable_id"], name: "index_photos_on_photographable_type_and_photographable_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "club"
    t.string   "country"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["id"], name: "index_players_on_id", using: :btree
  add_index "players", ["type"], name: "index_players_on_type", using: :btree

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "age",        limit: 3
    t.string   "gender"
    t.string   "salutation"
    t.string   "address"
  end

  add_index "students", ["email"], name: "index_students_on_email", using: :btree
  add_index "students", ["id"], name: "index_students_on_id", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["id"], name: "index_subjects_on_id", using: :btree
  add_index "subjects", ["name"], name: "index_subjects_on_name", using: :btree

  create_table "subjects_teachers_maps", force: true do |t|
    t.integer  "subject_id"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects_teachers_maps", ["id"], name: "index_subjects_teachers_maps_on_id", using: :btree
  add_index "subjects_teachers_maps", ["subject_id"], name: "index_subjects_teachers_maps_on_subject_id", using: :btree
  add_index "subjects_teachers_maps", ["teacher_id"], name: "index_subjects_teachers_maps_on_teacher_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_completed", default: false
    t.string   "priority"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["id"], name: "index_tasks_on_id", using: :btree
  add_index "tasks", ["is_completed"], name: "index_tasks_on_is_completed", using: :btree
  add_index "tasks", ["priority"], name: "index_tasks_on_priority", using: :btree
  add_index "tasks", ["teacher_id"], name: "index_tasks_on_teacher_id", using: :btree

  create_table "teachers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "age",        limit: 3
    t.string   "gender"
    t.string   "salutation"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", using: :btree
  add_index "teachers", ["id"], name: "index_teachers_on_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["id"], name: "index_users_on_id", using: :btree

end
