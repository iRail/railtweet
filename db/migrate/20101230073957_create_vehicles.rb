class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.string  :complete_number
      t.string  :train_type
      t.string  :train_number
      
      t.integer :number_of_stops
      t.integer :from_station_id
      t.integer :to_station_id
      t.integer :departure_hour
      t.integer :departure_min
      t.string  :departure_time

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
