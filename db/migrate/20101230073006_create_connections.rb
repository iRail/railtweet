class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.integer :one_way_trip_id
      t.integer :departure_id
      t.integer :arrival_id
      t.integer :via_id

      t.timestamps
    end
  end

  def self.down
    drop_table :connections
  end
end
