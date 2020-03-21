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

ActiveRecord::Schema.define(version: 2020_03_05_162902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cbsas", force: :cascade do |t|
    t.string "cbsa", limit: 5, null: false
    t.integer "statistical_area_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cbsa"], name: "index_cbsas_on_cbsa"
    t.index ["statistical_area_id"], name: "index_cbsas_on_statistical_area_id"
  end

  create_table "statistical_areas", force: :cascade do |t|
    t.string "cbsa", limit: 5, null: false
    t.string "mdiv", limit: 5
    t.string "name", limit: 50, null: false
    t.string "lsad", limit: 50, null: false
    t.integer "popestimate_2014", null: false
    t.integer "popestimate_2015", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cbsa"], name: "index_statistical_areas_on_cbsa"
  end

  create_table "zip_codes", force: :cascade do |t|
    t.string "zip_code", limit: 5, null: false
    t.integer "cbsa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cbsa_id"], name: "index_zip_codes_on_cbsa_id"
    t.index ["zip_code"], name: "index_zip_codes_on_zip_code"
  end

end
