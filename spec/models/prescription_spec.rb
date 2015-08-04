describe Prescription do

  before(:each) do
    @valid_prescription = Prescription.new(
        patient: Patient.new(),
        medication: Medication.new(),
        dose: "5 mg",
        recurrence: IceCube::Schedule.new(now),
        start: DateTime.new(2015, 8, 4, 12),
        end: DateTime.new(2015, 8, 18, 12)
    )
  end

  it "is valid with a patient, medication, dose, recurrence, start, and end" do
    expect(@valid_prescription).to be_valid
  end

  it "is invalid without a patient" do
    prescription = @valid_prescription
    prescription.patient = nil
    expect(prescription).to_not be_valid
    prescription.valid?
    expect(prescription.errors[:patient]).to include("Prescription must be assigned to a patient.")
  end

  it "is invalid without a medication" do
    prescription = @valid_prescription
    prescription.medication = nil
    expect(prescription).to_not be_valid
    prescription.valid?
    expect(prescription.errors[:medication]).to include("Prescription must have a medication.")
  end

  it "is invalid without a dose" do
    prescription = @valid_prescription
    prescription.dose = nil
    expect(prescription).to_not be_valid
    prescription.valid?
    expect(prescription.errors[:dose]).to include("Prescription must have a dose.")
  end

  it "is invalid without a recurrence" do
    prescription = @valid_prescription
    prescription.recurrence = nil
    expect(prescription).to_not be_valid
    prescription.valid?
    expect(prescription.errors[:recurrence]).to include("Prescription must have a recurrence.")
  end

  it "is invalid without a start" do
    prescription = @valid_prescription
    prescription.start = nil
    expect(prescription).to_not be_valid
    prescription.valid?
    expect(prescription.errors[:start]).to include("Prescription must have a start date/time.")
  end

  it "is invalid without an end" do
    prescription = @valid_prescription
    prescription.end = nil
    expect(prescription).to_not be_valid
    prescription.valid?
    expect(prescription.errors[:start]).to include("Prescription must have an end date/time.")
  end

  it "is invalid if end is before start" do
    prescription = @valid_prescription
    prescription.start = DateTime.new(2015, 10, 1)
    prescription.end = DateTime.new(2015, 8, 15)
    expect(prescription).to_not be_valid
    prescription.valid?
    expect(prescription.errors[:end]).to include("Prescription end cannot be before start.")
  end

end