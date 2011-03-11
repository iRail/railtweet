class CreateVehicleStops < ActiveRecord::Migration
  def self.up
    create_table :vehicle_stops do |t|
      t.integer  :vehicle_id
      t.integer  :station_id
      t.datetime :arrival_time
      t.datetime :departure_time
      t.date     :stop_date
      t.string   :platform
      
      t.boolean  :was_cancelled
      t.boolean  :has_left
      t.datetime :actual_arrival_time
      t.datetime :actual_departure_time
      t.string   :actual_platform
      t.integer  :actual_delay

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicle_stops
  end
end
