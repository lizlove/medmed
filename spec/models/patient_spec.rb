require 'rails_helper'

describe Patient do
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
end