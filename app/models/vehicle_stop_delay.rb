class VehicleStopDelay < ActiveRecord::Base
  belongs_to :vehicle_stop
  
  before_save :update_was_cancelled
  
  def update_was_cancelled
    if self.platform == "NA"
      self.was_cancelled = true
    end
  end
end
