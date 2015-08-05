class ScheduledDose < ActiveRecord::Base
  belongs_to :prescription
  validates :scheduled_time, :prescription_id, presence: true

  # def goodbye!(scheduled_time)
  #  @scheduled_time = scheduled_time
  #  @taken_time = nil 
  #  @side_effect = []
  #  @was_taken = false
  # end 

end
