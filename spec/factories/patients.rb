FactoryGirl.define do
  factory :patient do
    first_name "Bowser"
    last_name  "Koopa"
    email "patientbowser@nintendo.com"
    password "password"
    phone_number "330-503-6782"
    time_zone "Europe/Minsk"
  end
end