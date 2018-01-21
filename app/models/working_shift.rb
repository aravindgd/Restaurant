class WorkingShift < ActiveRecord::Base
  belongs_to :hotel 
  validate  :end_time_must_be_greater
  before_create :update_shift, :update_timing_values 
  

  def end_time_must_be_greater
  	if self.start_time.to_time.blank? && self.end_time.to_time.blank?
      errors.add(:base, "Improper time entered") 
  	elsif self.start_time.to_time > self.end_time.to_time
      errors.add(:base, "end time greater than start time")
    end
  end

  def update_shift
  	if self.start_time.to_time.hour < 12
      self.shift_type = "Morning"
    elsif self.start_time.to_time.hour > 12 && self.start_time.to_time.hour < 4
      self.shift_type = "Afternoon"
    else
      self.shift_type = "Evening"
    end	
  end
  
  def update_timing_values
  	self.start_time = self.start_time.to_time
    self.end_time = self.end_time.to_time
  end
end
