class Patient < ActiveRecord::Base

has_many :doctor_patients
has_many :doctors, through: :doctor_patients

#do we need to have password_confirmation here?
has_secure_password
validates :first_name, :last_name, :email, :password, :phone_number, presence: true

end