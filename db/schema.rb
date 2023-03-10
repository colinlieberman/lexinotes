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

ActiveRecord::Schema.define(version: 2023_01_27_003251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "citations", force: :cascade do |t|
    t.text "book", null: false
    t.integer "chapter", null: false
    t.integer "verse", null: false
    t.text "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book", "chapter", "verse"], name: "index_citations_on_book_and_chapter_and_verse"
    t.index ["book", "chapter"], name: "index_citations_on_book_and_chapter"
  end

  create_table "note_citations", force: :cascade do |t|
    t.bigint "note_id", null: false
    t.bigint "citation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["citation_id"], name: "index_note_citations_on_citation_id"
    t.index ["note_id", "citation_id"], name: "index_note_citations_on_note_id_and_citation_id", unique: true
    t.index ["note_id"], name: "index_note_citations_on_note_id"
  end

  create_table "note_tags", force: :cascade do |t|
    t.bigint "note_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["note_id", "tag_id"], name: "index_note_tags_on_note_id_and_tag_id", unique: true
    t.index ["note_id"], name: "index_note_tags_on_note_id"
    t.index ["tag_id"], name: "index_note_tags_on_tag_id"
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "study_date", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "notebook_number"
    t.integer "notebook_page"
    t.boolean "active", default: true, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "note_citations", "citations"
  add_foreign_key "note_citations", "notes"
  add_foreign_key "note_tags", "notes"
  add_foreign_key "note_tags", "tags"
end
