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

ActiveRecord::Schema.define(version: 2022_01_27_131557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "marks_reports", force: :cascade do |t|
    t.float "written"
    t.float "oral"
    t.float "total"
    t.string "remarks"
    t.bigint "student_terminal_subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_terminal_subject_id"], name: "index_marks_reports_on_student_terminal_subject_id"
  end

  create_table "student_terminal_subjects", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "subject_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "term_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.time "period_time"
    t.string "start_day"
    t.string "end_day"
    t.bigint "classroom_id"
    t.string "remarks"
    t.index ["classroom_id"], name: "index_student_terminal_subjects_on_classroom_id"
    t.index ["student_id"], name: "index_student_terminal_subjects_on_student_id"
    t.index ["subject_id"], name: "index_student_terminal_subjects_on_subject_id"
    t.index ["teacher_id"], name: "index_student_terminal_subjects_on_teacher_id"
    t.index ["term_id"], name: "index_student_terminal_subjects_on_term_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "second_name"
    t.string "last_name"
    t.string "father_name"
    t.string "mother_name"
    t.date "d_o_b"
    t.string "birth_cert"
    t.integer "contact_one"
    t.integer "contact_two"
    t.string "city"
    t.string "region"
    t.string "religion"
    t.string "qualifications"
    t.date "admission_date"
    t.integer "admission_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.string "book"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "credits"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "full_name"
    t.string "contact_no"
    t.string "full_address"
    t.string "qualification"
    t.string "staff_quarter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "joining_date"
  end

  create_table "terms", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_terms_on_student_id"
  end

  add_foreign_key "marks_reports", "student_terminal_subjects"
  add_foreign_key "student_terminal_subjects", "classrooms"
  add_foreign_key "student_terminal_subjects", "students"
  add_foreign_key "student_terminal_subjects", "subjects"
  add_foreign_key "student_terminal_subjects", "teachers"
  add_foreign_key "student_terminal_subjects", "terms"
  add_foreign_key "terms", "students"
end
