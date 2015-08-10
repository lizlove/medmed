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

  def side_effect_present?
    !(self.side_effect == "" || self.side_effect.nil?)
  end

  def missed?
    !self.was_taken? && self.scheduled_time < Time.now
  end

  def time_zone
    self.prescription.patient.translated_time_zone
  end

  def local_scheduled_time
    self.scheduled_time.in_time_zone(self.time_zone)
  end

  def formatted_time
    self.local_scheduled_time.strftime("%I:%M %p")
  end

end
