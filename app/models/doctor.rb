class Doctor < ActiveRecord::Base
has_many :doctor_patients
has_many :patients, through: :doctor_patients

#do we need to have password_confirmation here?
validates :first_name, :last_name, :email, :phone_number, :password, :password_confirmation, presence: true

end