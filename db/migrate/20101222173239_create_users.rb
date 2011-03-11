class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :provider
      t.string   :uid
      t.string   :name
      t.string   :nickname
      t.string   :image
      t.string   :background_image
      t.integer  :way_there_slot_start_hour
      t.integer  :way_there_slot_end_hour
      t.integer  :way_back_slot_start_hour
      t.integer  :way_back_slot_end_hour
      t.integer  :way_there_slot_start_min
      t.integer  :way_there_slot_end_min
      t.integer  :way_back_slot_start_min
      t.integer  :way_back_slot_end_min
      t.boolean  :tweets_active
      t.boolean  :include_l
      t.boolean  :include_ir
      t.boolean  :include_ic
      t.integer  :delay_tolerance
      t.integer  :from_station_id
      t.integer  :to_station_id
      t.integer  :way_there_id
      t.integer  :way_back_id
      t.string   :language
      
      t.timestamps
    end
    
    add_index :users, [:provider, :uid], :unique => true
  end

  def self.down
    drop_table :users
  end
end
