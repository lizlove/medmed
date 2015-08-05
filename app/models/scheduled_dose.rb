class ScheduledDose < ActiveRecord::Base
  belongs_to :prescription
  validates :scheduled_time, :prescription_id, presence: true

  # def goodbye!(scheduled_time)
  #  @scheduled_time = scheduled_time
  #  @taken_time = nil 
  #  @side_effect = []
  #  @was_taken = false
  # end

  def was_taken?
    was_taken
  end

  def panel_class
    if !self.was_taken? && self.scheduled_time < Time.now
      "danger"
    elsif self.was_taken?
      "default"
    else
      "primary"
    end
  end

end
