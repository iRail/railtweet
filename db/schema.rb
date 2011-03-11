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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110104052857) do

  create_table "connections", :force => true do |t|
    t.integer  "one_way_trip_id"
    t.integer  "departure_id"
    t.integer  "arrival_id"
    t.integer  "via_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "one_way_trips", :force => true do |t|
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", :force => true do |t|
    t.string   "code"
    t.string   "code_nmbs"
    t.string   "name_nl"
    t.string   "name_en"
    t.string   "name_fr"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stations", ["code"], :name => "index_stations_on_code", :unique => true

  create_table "trackings", :force => true do |t|
    t.string   "task"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "duration"
    t.integer  "number_of_objects"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "background_image"
    t.integer  "way_there_slot_start_hour"
    t.integer  "way_there_slot_end_hour"
    t.integer  "way_back_slot_start_hour"
    t.integer  "way_back_slot_end_hour"
    t.integer  "way_there_slot_start_min"
    t.integer  "way_there_slot_end_min"
    t.integer  "way_back_slot_start_min"
    t.integer  "way_back_slot_end_min"
    t.boolean  "tweets_active"
    t.boolean  "include_l"
    t.boolean  "include_ir"
    t.boolean  "include_ic"
    t.integer  "delay_tolerance"
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.integer  "way_there_id"
    t.integer  "way_back_id"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid", :unique => true

  create_table "vehicle_stop_delays", :force => true do |t|
    t.integer  "vehicle_stop_id"
    t.integer  "delay"
    t.boolean  "was_cancelled"
    t.boolean  "has_left"
    t.string   "platform"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicle_stops", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "station_id"
    t.datetime "arrival_time"
    t.datetime "departure_time"
    t.date     "stop_date"
    t.string   "platform"
    t.boolean  "was_cancelled"
    t.boolean  "has_left"
    t.datetime "actual_arrival_time"
    t.datetime "actual_departure_time"
    t.string   "actual_platform"
    t.integer  "actual_delay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", :force => true do |t|
    t.string   "complete_number"
    t.string   "train_type"
    t.string   "train_number"
    t.integer  "number_of_stops"
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.integer  "departure_hour"
    t.integer  "departure_min"
    t.string   "departure_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
