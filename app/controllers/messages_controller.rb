class MessagesController < ApplicationController

  def authenticate_user!
    return if doctor_signed_in?
    return if patient_signed_in?
  end

  before_action :authenticate_user!
 
  def new
  end
 
  def create
    umn = user_model_name
    recipients = "#{umn.capitalize}".constantize.where(id: params['recipients'])
    conversation = send("current_#{umn}").send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    conversation.save
    flash[:success] = "Message has been sent!"
    redir_url = send("#{umn}_conversation_path", send("current_#{umn}"), conversation)
    redirect_to redir_url
  end

  private

  def user_model_name
    if doctor_signed_in?
      "doctor"
    elsif patient_signed_in?
      "patient"
    end
  end
end