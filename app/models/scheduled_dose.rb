class ScheduledDose < ActiveRecord::Base
  belongs_to :perscriptions
  belongs_to :medications, through :perscriptions

      # t.integer :prescription_id
      # t.datetime :scheduled_time
      # t.datetime :taken_time
      # t.text :side_effect
      # t.boolean :was_taken


  # def self.side_effect
  # call the API? then populate the list? 
  # end

  def self.was_taken
    # how the F do I do this in Ruby?
    $("#taken").is(':checked') ? true : false;
  end



end
