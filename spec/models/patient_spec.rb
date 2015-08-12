require 'rails_helper'

describe Patient do

  describe 'valid?' do

    it 'is invalid without a timezone' do
      patient = build(:patient)
      patient.time_zone = nil
      expect(patient).to_not be_valid
    end

    it 'is invalid without a valid Twilio mobile number' do
      patient = build(:patient)
      patient.phone_number = '123-456-7892'
      expect(patient).to_not be_valid
    end

    it 'is valid with a valid Twilio mobile number' do
      patient = build(:patient)
      patient.phone_number = '773-600-2167' #this is a landline. change to mobile.
      expect(patient).to be_valid
    end


  end


  describe 'missed_scheduled_dose?' do
    it 'returns true if patient missed a dose yesterday' do
      patient = create(:patient)
      patient.prescriptions.build(:prescription_one_day_ago).add_daily_recurrence_rule(1)
      patient.save!
      expect(patient.missed_scheduled_dose?).to eq(true)
    end

    it 'returns false if patient did not miss a dose yesterday' do
      patient = create(:patient)
      expect(patient.missed_scheduled_dose?).to eq(false)
    end
  end

  describe 'translated_time_zone' do
    it 'returns the patients time zone as an ActiveSupport::TimeZone object' do
      @patient = Patient.create(time_zone: "Pacific/Midway")

      expect(@patient.translated_time_zone).to be_a(ActiveSupport::TimeZone)
      expect(@patient.translated_time_zone.name).to eq("Pacific/Midway")
    end
  end

  describe 'scheduled_doses_for_today' do
    it 'returns the patients scheduled doses for that day' do
      @patient = create(:patient)
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses

      expect(@patient.scheduled_doses_for_today.count).to eq(1)
    end
  end




end