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

ActiveRecord::Schema[7.2].define(version: 2024_10_14_184014) do
  create_table "climates", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_climates_on_description", unique: true
  end

  create_table "climates_planets", id: false, force: :cascade do |t|
    t.integer "planet_id", null: false
    t.integer "climate_id", null: false
    t.index ["climate_id"], name: "index_climates_planets_on_climate_id"
    t.index ["planet_id"], name: "index_climates_planets_on_planet_id"
  end

  create_table "planets", force: :cascade do |t|
    t.text "name"
    t.integer "population"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_planets_on_name", unique: true
  end

  create_table "planets_terrains", id: false, force: :cascade do |t|
    t.integer "planet_id", null: false
    t.integer "terrain_id", null: false
    t.index ["planet_id"], name: "index_planets_terrains_on_planet_id"
    t.index ["terrain_id"], name: "index_planets_terrains_on_terrain_id"
  end

  create_table "terrains", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_terrains_on_description", unique: true
  end
end
