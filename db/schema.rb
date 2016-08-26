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

ActiveRecord::Schema.define(version: 20160826041632) do

  create_table "cars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "model"
    t.string   "brand"
    t.integer  "year"
    t.integer  "miles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "entity_type"
    t.integer  "entity_id"
    t.string   "tag_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["entity_type", "entity_id"], name: "index_tags_on_entity_type_and_entity_id", using: :btree
    t.index ["tag_name"], name: "index_tags_on_tag_name", using: :btree
  end

end