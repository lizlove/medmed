require 'rails_helper'

describe SmsWrapper do
  describe 'valid_phone_number?' do
    before do
      class FakeMessage
        def sms
          "Test message"
        end
      end

      @message = FakeMessage.new
    end
    it 'returns false if the phone number is an invalid mobile number' do
      @user = create(:patient)
      @user.phone_number = '55-11-5525-6325'
      @sms = SmsWrapper.new(@user, @message)

      expect(@sms.valid_phone_number?).to eq(false)
    end

    it 'returns true if the phone number is a valid mobile number' do
      @user = create(:patient)
      @user.phone_number = '202-555-0193'
      @sms = SmsWrapper.new(@user, @message)

      expect(@sms.valid_phone_number?).to eq(true)
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

    it 'sends an sms to a user with a valid phone number' do
      @user = create(:patient)
      @user.phone_number = '202-500-2367' #replace with a valid mobile number
      @sms = SmsWrapper.new(@user, @message)

      expect(@sms.send_message).to be_a(Twilio::REST::Message)
    end
  end
end