class SmsWrapper

    FROM_PHONE = ENV["TWILIO_FROM_PHONE"]
    ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
    AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

    # set up a client to talk to the Twilio REST API

    def initialize
        @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    end


    def send_message(phone_number, body)
        @client.account.messages.create({:from => FROM_PHONE, :to => phone_number, :body => body})
    end

end