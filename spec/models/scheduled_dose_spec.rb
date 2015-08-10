require 'rails_helper'

describe ScheduledDose do

  describe 'scheduled_time' do
    it 'returns the scheduled time of the dose in UTC' do
      @patient = Patient.new
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses.first

      expect(@sd.scheduled_time.time_zone.name).to eq("UTC")
    end

    it 'does not return the scheuled time of the dose in the patients time zone' do
      @patient = Patient.new
      @patient.time_zone = "Europe/Minsk"
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses.first

      expect(@sd.scheduled_time.time_zone.name).to_not eq("Europe/Minsk")
    end

  end

  describe 'local_scheduled_time' do
    it 'returns the time in the patients time zone' do
      @patient = Patient.new
      @patient.time_zone = "Europe/Minsk"
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses.first

      expect(@sd.local_scheduled_time.time_zone.name).to eq("Europe/Minsk")
    end

  end

  describe 'formatted_time' do
    it 'returns the properly formatted scheduled time' do

      @patient = Patient.new
      @patient.time_zone = "Europe/Minsk"
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses.first

      expect(@sd.formatted_time).to match(/\d\d:\d\d\s[P|A]M/)
    end
  end


end
