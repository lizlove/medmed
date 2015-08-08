require 'rails_helper'

describe ScheduledDose do

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
