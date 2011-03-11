class CreateVehicleStopDelays < ActiveRecord::Migration
  def self.up
    create_table :vehicle_stop_delays do |t|
      t.integer  :vehicle_stop_id
      
      t.integer  :delay
      t.boolean  :was_cancelled
      t.boolean  :has_left
      t.string   :platform
      t.string   :source
      
      t.timestamps
    end
  end

  def self.down
    drop_table :vehicle_stop_delays
  end
end
