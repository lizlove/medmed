class DoctorComplianceData
  attr_reader :patients, :doctor

  def initialize(doctor)
    @doctor = doctor
    @patients = @doctor.patients
  end 

  def patients_labelmaker
    patients.collect{|patient| patient.name}
  end

  def single_prescription_compliance_percentage_calculator(prescription)
      num = prescription.scheduled_doses.where(was_taken: true).length 
      denom = prescription.scheduled_doses.where(scheduled_time: (100.years.ago)..(Time.now)).length 
      (num.to_f)/(denom.to_f)
  end  

  def total_patient_compliance_calculator(patient)
    if patient.prescriptions.any?
      total_patient_compliance_array = patient.prescriptions.collect{|prescription| self.single_prescription_compliance_percentage_calculator(prescription)}
      average_patients_compliance_figure(total_patient_compliance_array)
    else
      100
    end
  end

  def average_patients_compliance_figure(total_patient_compliance_array)
    ((total_patient_compliance_array.inject(:+).to_f / total_patient_compliance_array.size) * 100).to_i
  end

  def all_doctor_patients_compliance_array
    patients.collect{|patient| total_patient_compliance_calculator(patient)}
  end 

  def total_doctor_patients_compliance_figure
    if doctor.patients.any?
    (all_doctor_patients_compliance_array.inject(:+).to_f / all_doctor_patients_compliance_array.size).to_i
    else 
      100
    end

  end 

end 