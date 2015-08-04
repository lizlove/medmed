class Prescription < ActiveRecord::Base
  belongs_to :patient
  belongs_to :medication
  has_many :scheduled_doses
end