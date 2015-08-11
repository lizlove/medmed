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
    @recurrence ||= IceCube::Schedule.new(start = self.start_datetime.utc, :end_time => self.end_datetime.utc)
  end

  def recurrence_is_scheduled?
    self.recurrence.rrules.any?
  end

  def build_scheduled_doses
    self.recurrence.occurrences(self.end_datetime).each do |occurrence|
      self.scheduled_doses.build(scheduled_time: occurrence)
    end
  end

  def add_daily_recurrence_rule(interval)
    self.recurrence.add_recurrence_rule IceCube::Rule.daily(interval)
  end

  def add_hourly_recurrence_rule(interval)
    self.recurrence.add_recurrence_rule IceCube::Rule.hourly(interval)
  end

  def add_recurrence_rule(interval, type, days=[])
    type = type.downcase
    if type == "weekly"
      self.add_weekly_recurrence_rule_with_days(interval, days)
    elsif type == "hourly"
      self.add_hourly_recurrence_rule(interval)
    else
      self.add_daily_recurrence_rule(interval) 
    end
  end

  def add_weekly_recurrence_rule_with_days(interval, days)
    self.recurrence.add_recurrence_rule IceCube::Rule.weekly(interval).day(days)
  end

  def get_script_label
    FdaWrapper.parse_label
  end 

  def get_disclaimer
    rxstr = self.rxcui.to_s
    FdaWrapper.request(rxstr)
    FdaWrapper.parse_disclaimer
  end 

  def get_image
    rxstr = self.rxcui.to_s
    PillboxWrapper.request(rxstr)
  end 

  private
  def start_before_end
    if self.start_datetime && self.end_datetime
      errors.add(:start, "start date/time should be before end date/time") unless self.start_datetime < self.end_datetime
    end
  end

end