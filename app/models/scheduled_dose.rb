class ScheduledDose < ActiveRecord::Base
  belongs_to :prescription
  belongs_to :medication, through :prescription

  validates :scheduled_time, :prescription_id, presence: true

  def initialize
   self.taken_time = nil 
   self.side_effect = []
   self.was_taken = false
  end 

end
