class Doctor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
has_many :doctor_patients
has_many :patients, through: :doctor_patients

#do we need to have password_confirmation here?
# has_secure_password

# validates :first_name, :last_name, :email, :phone_number, :password, presence: true

end