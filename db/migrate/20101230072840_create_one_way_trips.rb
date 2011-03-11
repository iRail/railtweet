class CreateOneWayTrips < ActiveRecord::Migration
  def self.up
    create_table :one_way_trips do |t|
      t.integer :from_station_id
      t.integer :to_station_id

      t.timestamps
    end
  end

  def self.down
    drop_table :one_way_trips
  end
end
