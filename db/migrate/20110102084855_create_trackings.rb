class CreateTrackings < ActiveRecord::Migration
  def self.up
    create_table :trackings do |t|
      t.string    :task
      t.datetime  :start_time
      t.datetime  :end_time
      t.integer   :duration
      t.integer   :number_of_objects
      t.string    :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :trackings
  end
end
