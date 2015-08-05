require 'rails_helper'

describe Prescription do

  describe 'valid?' do

    it "is valid with a patient, doctor, medication_name, rxcuid, recurrence, start, and end" do
      prescription = build(:prescription)
      expect(prescription).to be_valid
    end

    it "is invalid without a doctor" do
      prescription = build(:prescription)
      prescription.doctor = nil
      expect(prescription).to_not be_valid
    end

    it "is invalid without a patient" do
      prescription = build(:prescription)
      prescription.patient = nil
      expect(prescription).to_not be_valid
    end


    it "is invalid without a rxcui" do
      prescription = build(:prescription)
      prescription.rxcui = nil
      expect(prescription).to_not be_valid
    end

    it "is invalid without a medication name" do
      prescription = build(:prescription)
      prescription.medication_name = nil
      expect(prescription).to_not be_valid
    end


    it "is invalid without a start" do
      prescription = build(:prescription)
      prescription.start_datetime = nil
      expect(prescription).to_not be_valid
    end

    it "is invalid without an end" do
      prescription = build(:prescription)
      prescription.end_datetime = nil
      expect(prescription).to_not be_valid
    end

    it "is invalid if end is before start" do
      prescription = build(:prescription)
      prescription.start_datetime = Time.new(2015, 10, 1)
      prescription.end_datetime = Time.new(2015, 8, 15)
      expect(prescription).to_not be_valid
    end


  end

  describe 'recurrence' do

    it "is an instance of IceCube::Schedule" do
      prescription = build(:prescription)
      expect(prescription.recurrence).to be_a(IceCube::Schedule)
    end
  end


end