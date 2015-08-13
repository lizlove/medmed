class ScheduledDose < ActiveRecord::Base
  belongs_to :prescription
  delegate :medication_name, :patient, :to => :prescription
  delegate :translated_time_zone, :to => :patient
  validates :scheduled_time, :prescription_id, presence: true

  before_save :empty_side_effect, unless: :was_taken?
  after_create :reminder

  def was_taken?
    self.was_taken
  end

  def side_effect_present?
    self.side_effect != "" && self.side_effect
  end

  def missed?
    !self.was_taken? && self.scheduled_time < Time.now
  end


  def local_scheduled_time
    self.scheduled_time.in_time_zone(self.translated_time_zone)
  end

  def reminder
    SmsWrapper.new(self.patient).send_message(ScheduledDoseView.new(self))
  end

  def patient_phone_number
    self.patient.phone_number
  end

  def when_to_remind
    scheduled_time - 15.minutes
  end

  handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_remind }

  private

  def empty_side_effect
    self.side_effect = nil
  end

end
