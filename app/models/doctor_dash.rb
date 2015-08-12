class DoctorDash

  def self.compliance_by_patient(patient_id)
    patient = Patient.find(patient_id)
    comply_array = patient.prescriptions.collect do |prescription| 
        num = prescription.scheduled_doses.where(was_taken: true).length 
        denom = prescription.scheduled_doses.where(scheduled_time: (100.years.ago)..(Time.now)).length 
        (num.to_f)/(denom.to_f)
        binding.pry
      end 
      comply_array
      comply_array.inject{ |sum, el| sum + el }.to_f / comply_array.size
  end

  def self.total_compliance(doctor_id)
    @patients.collect do |patient|
      DoctorDash.compliance_by_patient(patient.id)
    end 
  end 

  def self.timerange(patient_id)
    patient = Patient.find(patient_id)
  end 

  def self.patients_per_doctor(doctor_id)
    doctor = Doctor.find(doctor_id)
    @patients = doctor.patients
    @patients.collect{|patient| patient.name}
  end 

  def self.compliance_all_patients
    
  end 

end 