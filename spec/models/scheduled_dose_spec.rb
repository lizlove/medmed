require 'rails_helper'

describe ScheduledDose do

  describe 'scheduled_time' do
    it 'returns the scheduled time of the dose in UTC' do
      @patient = create(:patient)
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses.first

      expect(@sd.scheduled_time.time_zone.name).to eq("UTC")
    end

    it 'does not return the scheduled time of the dose in the patients time zone' do
      @patient = create(:patient)
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
      @patient = create(:patient)
      @patient.time_zone = "Europe/Minsk"
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses.first

      expect(@sd.local_scheduled_time.time_zone.name).to eq("Europe/Minsk")
    end

  end


  describe 'empty_side_effect' do
    it 'does not save side effects if the dose hasnt been taken' do

      @patient = create(:patient)
      @prescription = create(:prescription, patient: @patient)
      @prescription.add_daily_recurrence_rule(1)
      @prescription.save
      @sd = @prescription.scheduled_doses.first

      @sd.side_effect = "Headaches, soreness, and dizziness"
      @sd.was_taken = false

      @sd.save

      expect(@sd.side_effect).to eq(nil)

    end
  end




end
