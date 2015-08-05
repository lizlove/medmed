class Patient < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :doctor_patients
has_many :doctors, through: :doctor_patients
has_many :prescriptions
has_many :scheduled_doses, through: :prescriptions

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def scheduled_doses_by_time
    self.scheduled_doses.order(:scheduled_time)
  end

  def scheduled_doses_for_today
    self.scheduled_doses_by_time.where({scheduled_time: DateTime.now.midnight..(DateTime.now.midnight + 1.day)})
  end

end