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

ActiveRecord::Schema.define(version: 20160427214252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bike_trips", force: :cascade do |t|
    t.integer  "trip_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "start_station_id"
    t.integer  "end_station_id"
    t.string   "trip_route_category"
    t.string   "passholder_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "bike_trips", ["start_station_id"], name: "index_bike_trips_on_start_station_id", using: :btree

  create_table "dailies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade do |t|
    t.integer  "station_id"
    t.string   "station_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "stations", ["station_id"], name: "index_stations_on_station_id", using: :btree

end
