class Vehicle < ActiveRecord::Base
  has_many :vehicle_stops
  belongs_to :from_station, :class_name => "Station"
  belongs_to :to_station, :class_name => "Station"
  
  before_save :update_train_type_and_train_number
  
  validates :complete_number, :uniqueness => true
  validates :train_number, :uniqueness => true
  
  def update_train_type_and_train_number
    self.train_type = self.complete_number.split(".").last.match(/\D+/)[0]
    self.train_number = self.complete_number.split(".").last.match(/\d+/)[0]
    if self.departure_hour and self.departure_min
      self.departure_time = '%02d:%02d' % [self.departure_hour,self.departure_min]
    end
  end
  
end
