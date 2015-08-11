module Userify
  
  def name
    "#{self.first_name} #{self.last_name}"
  end

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    if [].include?(object)
      self.email
    end
    #if false
    #return nil
  end
end