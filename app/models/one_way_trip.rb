class OneWayTrip < ActiveRecord::Base
  belongs_to :from_station, :class_name => "Station"
  belongs_to :to_station, :class_name => "Station"
  has_many :connections
  
  def name
    "#{self.from_station.code} - #{self.to_station.code}"
  end
end
