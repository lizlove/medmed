FactoryGirl.define do
  factory :prescription do
    rxcui  "541879"
    medication_name "Amphetamine aspartate 1.25 MG"
    start_datetime { Time.now() }
    end_datetime { Time.now() + 3.months }
    patient
    doctor
  end

  factory :prescription_one_day_ago do
    rxcui  "541879"
    medication_name "Amphetamine aspartate 1.25 MG"
    start_datetime { Time.now() - 1.days }
    end_datetime { Time.now() + 1.days }
    patient
    doctor
  end
end
