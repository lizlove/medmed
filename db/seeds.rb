Doctor.destroy_all
Patient.destroy_all
Prescription.destroy_all
ScheduledDose.destroy_all


# Patients
@patient1 = Patient.new(first_name: "Princess", last_name: "Peach", phone_number: "7736002167", email: "peach@nintendo.com", password: "marioh0t", password_confirmation: "marioh0t", time_zone: "Eastern Time (US & Canada)")
@patient2 = Patient.new(first_name: "Bowser", last_name: "Koopa", phone_number: "804-596-0952", email: "koopa@nintendo.com", password: "kooparules", password_confirmation: "kooparules", time_zone: "Eastern Time (US & Canada)")
@patient3 = Patient.new(first_name: "Kirby", last_name: "PinkPuff", phone_number: "834-596-0952", email: "kirby@nintendo.com", password: "dreamland", password_confirmation: "dreamland", time_zone: "Eastern Time (US & Canada)")
@patient4 = Patient.new(first_name: "Link", last_name: "Legend", phone_number: "834-596-0452", email: "link@nintendo.com", password: "findzelda", password_confirmation: "findzelda", time_zone: "Eastern Time (US & Canada)")


@patient1.save!(validate: false)
@patient2.save!(validate: false)
@patient3.save!(validate: false)
@patient4.save!(validate: false)


# Doctors
@doctor1 = Doctor.create!(first_name: "Jumpman", last_name: "Mario", phone_number: "329-324-2343", email: "drmario@nintendo.com", password: "wariosux", password_confirmation: "wariosux", time_zone: "Eastern Time (US & Canada)")
@doctor2 = Doctor.create!(first_name: "Toad", last_name: "Mushroom", phone_number: "329-324-2393", email: "toad@nintendo.com", password: "toadrules", password_confirmation: "toadrules", time_zone: "Eastern Time (US & Canada)")

#Prescription
@prescrip1 = Prescription.new(patient_id: @patient1.id, rxcui: 861007, start_datetime: Time.now - 60.days, end_datetime: Time.now + 12.hours, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/00007-4895-20_D218E947.jpg", medication_name: "Requip 3 MG Oral Tablet")
@prescrip1.save
@prescrip1.add_daily_recurrence_rule(1)
@prescrip1.save
@sd1 = @prescrip1.scheduled_doses
@sd1.each.with_index do |dose, i|
  if i > 55
    dose.was_taken = false
    dose.save
  else
    dose.was_taken = true 
    dose.save
  end 
end 

@prescrip2 = Prescription.new(patient_id: @patient1.id, rxcui: 617314, start_datetime: Time.now - 25.days, end_datetime: Time.now + 12.hours, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/540920173.jpg", medication_name: "atorvastatin 10 MG Oral Tablet [Lipitor]")
@prescrip2.save
@prescrip2.add_daily_recurrence_rule(1)
@prescrip2.save
@sd2 = @prescrip2.scheduled_doses
@sd2.each do |dose|
  dose.was_taken = true 
  dose.taken_time = dose.scheduled_time + 4.hours
  dose.save
end 

@prescrip3 = Prescription.new(patient_id: @patient1.id, rxcui: 261442, start_datetime: Time.now - 40.days, end_datetime: Time.now + 12.hours, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/647640301.jpg", medication_name: "pioglitazone 15 MG [Actos]")
@prescrip3.save
@prescrip3.add_daily_recurrence_rule(1)
@prescrip3.save
@sd3 = @prescrip3.scheduled_doses
@sd3.each do |dose|
  dose.was_taken = true
  dose.save
  dose.taken_time = dose.scheduled_time + 30.minutes
  dose.side_effect = "sore throat"
  dose.save
end 


@prescrip4 = Prescription.new(patient_id: @patient2.id, rxcui: 617314, start_datetime: Time.now - 11.days , end_datetime: Time.now + 12.hours, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/540920173.jpg", medication_name: "atorvastatin 10 MG Oral Tablet [Lipitor]")
@prescrip4.save
@prescrip4.add_daily_recurrence_rule(2)
@prescrip4.save
@sd4 = @prescrip4.scheduled_doses
@sd4.each.with_index do |dose, i|
  if i < 4
    dose.was_taken = true 
    dose.save
  else
    dose.was_taken = false
    dose.save
  end 
end 

@prescrip5 = Prescription.new(patient_id: @patient3.id, rxcui: 565420, start_datetime: Time.now - 11.days , end_datetime: Time.now + 12.hours, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/000060711.jpg", medication_name: "Singulair 4 MG Chewable Tablet")
@prescrip5.save
@prescrip5.add_daily_recurrence_rule(2)
@prescrip5.save
@sd5 = @prescrip5.scheduled_doses
@sd5.each.with_index do |dose, i|
  if i < 3
    dose.was_taken = true 
    dose.save
  else 
    dose.was_taken = false
    dose.save
  end
end 

@prescrip6 = Prescription.new(patient_id: @patient4.id, rxcui: 566660, start_datetime: Time.now - 21.days , end_datetime: Time.now + 12.hours, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/001439928.jpg", medication_name: "Ciprofloxacin (as ciprofloxacin hydrochloride) 500 MG Oral Tablet")
@prescrip6.save
@prescrip6.add_daily_recurrence_rule(2)
@prescrip6.save
@sd4 = @prescrip6.scheduled_doses
@sd4.each.with_index do |dose, i|
    if i < 10  
      dose.was_taken = true 
      dose.taken_time = dose.scheduled_time + 10.minutes
      dose.save
    else 
      dose.was_taken = false
      dose.save  
    end 
end 
