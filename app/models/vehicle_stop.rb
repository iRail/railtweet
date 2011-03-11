class VehicleStop < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :station
  has_many   :vehicle_stop_delays
  
  before_save :update_was_cancelled
  before_save :update_times
  
  def update_was_cancelled
    if self.actual_platform == "NA"
      self.was_cancelled = true
    end
  end
  
  def update_times
    self.actual_departure_time = self.departure_time + self.actual_delay.seconds if self.departure_time and self.actual_delay
    self.actual_arrival_time = self.arrival_time + self.actual_delay.seconds if self.arrival_time and self.actual_delay
  end
  
  def status
    return "left" if self.has_left
    return "cancelled" if self.was_cancelled
    return "delayed" if self.actual_delay and self.actual_delay > 0
    return "normal"
  end
  
  def actual_delay_in_minutes
    if actual_delay
      actual_delay / 60
    end
  end
  
end
