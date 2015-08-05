FactoryGirl.define do
  factory :prescription do
    dose  "5 mg"
    start_datetime { Time.now() }
    end_datetime { Time.now() + 3.months }
    patient
  end
end

# @valid_prescription = Prescription.new(
#     patient: Patient.new(),
#     dose: "5 mg",
#     start: Time.now(),
#     end: Time.new(2015, 10, 31))