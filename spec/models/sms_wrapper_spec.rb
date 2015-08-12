require 'rails_helper'

describe SmsWrapper do
  describe 'valid_phone_number?' do
    it 'returns false if the phone number is an invalid mobile number' do
      @user = create(:patient)
      @user.phone_number = '55-11-5525-6325'
      @sms = SmsWrapper.new(@user)

      expect(@sms.valid_phone_number?).to eq(false)
    end
  end
end