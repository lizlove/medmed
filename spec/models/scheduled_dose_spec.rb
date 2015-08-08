require 'rails_helper'

describe ScheduledDose do

  describe 'formatted_time' do
    it 'returns the patients translated start_time' do

      @sd = ScheduledDose.create(scheduled_time: Time.now)

      expect(@sd.formatted_time).to match(/\d\d:\d\d\s[p|a]m/)
    end
  end
end
