class SmsWrapper

    FROM_PHONE = ENV["TWILIO_FROM_PHONE"]
    ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
    AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

    # set up a client to talk to the Twilio REST API

    def initialize
        @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    end

    def send_message(user, view_object)
        begin
            @client.account.messages.create({:from => FROM_PHONE, :to => user.phone_number, :body => view_object.text_body})
        rescue Twilio::REST::RequestError
            puts "Something went wrong with the request"
        end

    end

end