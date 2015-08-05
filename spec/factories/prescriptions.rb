FactoryGirl.define do
  factory :prescription do
    rxcui  "541879"
    medication_name "Amphetamine aspartate 1.25 MG"
    start_datetime { Time.now() }
    end_datetime { Time.now() + 3.months }
    patient
    doctor
  end
end
