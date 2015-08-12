class Patient < ActiveRecord::Base
  acts_as_messageable
  include Userify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :phone_number, :email, presence: true
  validate :phone_number_is_valid_mobile

  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
  has_many :prescriptions
  has_many :scheduled_doses, through: :prescriptions

  def translated_time_zone
    ActiveSupport::TimeZone.new(self.time_zone)
  end

  def scheduled_doses_for_today
    scheduled_doses_by_time.where({scheduled_time: Time.now.midnight..(Time.now.midnight + 1.day)})
  end

  def missed_doses_for_yesterday
    scheduled_doses_by_time.where({scheduled_time: (Time.now.midnight-1.day)..(Time.now.midnight), was_taken: false})
  end

  def missed_scheduled_dose?
    self.missed_doses_for_yesterday.any?
  end

  private
  def phone_number_is_valid_mobile
    if !(SmsWrapper.new(self).valid_phone_number?)
      errors.add(:phone_number, "please enter a valid cell phone number")
    end
  end

  def scheduled_doses_by_time
    self.scheduled_doses.order(:scheduled_time)
  end

end