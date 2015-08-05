Doctor.destroy_all
Patient.destroy_all
Prescription.destroy_all
ScheduledDose.destroy_all


# Patients
@patient1 = Patient.create!(first_name: "Princess", last_name: "Peach", phone_number: "804-596-0982", email: "peach@nintendo.com", password: "marioh0t", password_confirmation: "marioh0t")
Patient.create!(first_name: "Bowser", last_name: "Koopa", phone_number: "804-596-0952", email: "koopa@nintendo.com", password: "kooparules", password_confirmation: "kooparules")

# Doctors
@doctor1 = Doctor.create!(first_name: "Jumpman", last_name: "Mario", phone_number: "329-324-2343", email: "drmario@nintendo.com", password: "wariosux", password_confirmation: "wariosux")
Doctor.create!(first_name: "Toad", last_name: "Mushroom", phone_number: "329-324-2393", email: "toad@nintendo.com", password: "toadrules", password_confirmation: "toadrules")

#Prescription
Prescription.create(patient_id: @patient1.id, rxcui: 541894, start_datetime: Time.now, end_datetime: Time.now + 5.days, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/540920173.jpg", medication_name: "Dextroamphetamine saccharate 2.5 MG")

Prescription.create(patient_id: @patient1.id, rxcui: 617314, start_datetime: Time.now, end_datetime: Time.now + 15.days, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/540920173.jpg", medication_name: "atorvastatin 10 MG Oral Tablet [Lipitor]")

Prescription.create(patient_id: @patient1.id, rxcui: 541894, start_datetime: Time.now, end_datetime: Time.now + 5.days, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/540920173.jpg", medication_name: "Dextroamphetamine saccharate 2.5 MG")

Prescription.create(patient_id: @patient1.id, rxcui: 617314, start_datetime: Time.now, end_datetime: Time.now + 14.days, doctor_id: @doctor1.id, side_effects: nil, image_url: "http://pillbox.nlm.nih.gov/assets/small/540920173.jpg", medication_name: "atorvastatin 10 MG Oral Tablet [Lipitor]")





