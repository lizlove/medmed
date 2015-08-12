require 'rails_helper'

describe SmsWrapper do
  describe 'valid_phone_number?' do

    it 'returns false if the phone number is an invalid mobile number' do
      @user = create(:patient)
      @user.phone_number = '55-11-5525-6325'
      @sms = SmsWrapper.new(@user)

      expect(@sms.valid_phone_number?).to eq(false)
    end

    it 'returns true if the phone number is a valid mobile number' do
      @user = create(:patient)
      @user.phone_number = '202-555-0193'
      @sms = SmsWrapper.new(@user)

      expect(@sms.valid_phone_number?).to eq(true)
    end

    it 'rescues from a phone number not being found' do
      @user = create(:patient)
      @user.phone_number = '123-456-7892'
      @sms = SmsWrapper.new(@user)

      expect(@sms.valid_phone_number?).to eq(false)
    end

  end

  describe 'send_message' do
    before do
      class FakeMessage
        def sms
          "Test message"
        end
      end

      @message = FakeMessage.new
    end

    xit 'sends an sms to a user with a valid phone number' do
      @user = create(:patient)
      @user.phone_number = '' #replace with a valid mobile number
      @sms = SmsWrapper.new(@user)

      expect(@sms.send_message(@message)).to be_a(Twilio::REST::Message)
    end

    it 'rescues from an request error' do
      @user = create(:patient)
      @user.phone_number = '123-456-7892'
      @sms = SmsWrapper.new(@user)

      expect(@sms.send_message(@message)).to eq(false)
    end
  end
end