class Prescription < ActiveRecord::Base
  include IceCube
  belongs_to :patient
  belongs_to :doctor
  has_many :scheduled_doses
  serialize :recurrence, IceCube::Schedule

  validates :patient, :doctor, :rxcui, :medication_name, :start_datetime, :end_datetime, :presence => true
  validate :start_before_end

  before_save :build_scheduled_doses, if: :recurrence_is_scheduled?


  def recurrence
    @recurrence ||= IceCube::Schedule.new(start = self.start_datetime, :end_time => self.end_datetime)
  end

  def recurrence_is_scheduled?
    !self.recurrence.instance_variable_get("@all_recurrence_rules").empty?
  end

  def build_scheduled_doses
    self.recurrence.occurrences(self.end_datetime).each do |occurrence|
      self.scheduled_doses.build(scheduled_time: occurrence)
    end
  end

  def add_daily_recurrence_rule(interval)
    self.recurrence.add_recurrence_rule IceCube::Rule.daily(interval)
  end

  def add_weekly_recurrence_rule(interval)
    self.recurrence.add_recurrence_rule IceCube::Rule.weekly(interval)
  end

  def add_monthly_recurrence_rule(interval)
    self.recurrence.add_recurrence_rule IceCube::Rule.monthly(interval)
  end

  def add_weekly_recurrence_rule_with_days(interval, days)
    self.recurrence.add_recurrence_rule IceCube::Rule.weekly(interval).day()
  end

  private
  def start_before_end
    if self.start_datetime && self.end_datetime
      errors.add(:start, "start date/time should be before end date/time") unless self.start_datetime < self.end_datetime
    end
  end

end