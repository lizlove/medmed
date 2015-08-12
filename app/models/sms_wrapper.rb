class SmsWrapper
    attr_reader :phone_number, :sms_client, :lookup_client

    FROM_PHONE = ENV["TWILIO_FROM_PHONE"]
    ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
    AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

    # set up a client to talk to the Twilio REST API

    def initialize(user)
        @sms_client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
        @lookup_client = Twilio::REST::LookupsClient.new(ACCOUNT_SID, AUTH_TOKEN)
        @phone_number = user.phone_number
    end

    def send_message(message_object)
        begin
            sms_client.account.messages.create({:from => FROM_PHONE, :to => phone_number, :body => message_object.sms})
        rescue => e
            Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
            false
        end
    end

    def valid_phone_number?
        begin
            response = lookup_client.phone_numbers.get(phone_number, type: 'carrier')
            response.carrier["type"] == 'mobile' ? true : false
        rescue => e
            if e.code == 20404
                false
            else
                puts "Something went wrong with the request"
            end

            Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
        end
    end

end