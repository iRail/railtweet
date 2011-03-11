class CreateStations < ActiveRecord::Migration
  def self.up
    create_table :stations do |t|
      t.string  :code
      t.string  :code_nmbs
      t.string  :name_nl
      t.string  :name_en
      t.string  :name_fr
      t.string  :region

      t.timestamps
    end
    
    add_index :stations, :code, :unique => true    
  end

  def self.down
    drop_table :stations
  end
end
