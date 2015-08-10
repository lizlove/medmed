class TwilioWrapper

    FROM_PHONE = ENV["TWILIO_FROM_PHONE"]


    ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
    AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

    # set up a client to talk to the Twilio REST API
    @@client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

    def self.send_message(patient, scheduled_dose)
      @@client.account.messages.create({
          :from => FROM_PHONE,
          :to => patient.phone_number,
          :body => "Hi #{patient.name}, this is a reminder from MedMed to take your scheduled dose of #{scheduled_dose.medication_name} at #{scheduled_dose.local_scheduled_time} today."
          ,
      })
    end


end