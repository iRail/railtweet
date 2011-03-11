class Connection < ActiveRecord::Base
  belongs_to :one_way_trip
  belongs_to :departure, :class_name => "VehicleStop"
  belongs_to :arrival, :class_name => "VehicleStop"
  belongs_to :via, :class_name => "VehicleStop" 
end
