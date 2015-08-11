class Doctor < ActiveRecord::Base
  acts_as_messageable
  include Userify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :doctor_patients
  has_many :patients, through: :doctor_patients
  has_many :prescriptions
  has_many :scheduled_doses, through: :prescriptions

end