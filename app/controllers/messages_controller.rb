class MessagesController < ApplicationController
  def authenticate_user!
    return if doctor_signed_in?
    return if patient_signed_in?
  end
  before_action :authenticate_user!
 
  def new
  end
 
  def create
    if doctor_signed_in?
      recipients = Patient.where(id: params['recipients'])
      conversation = current_doctor.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
      flash[:success] = "Message has been sent!"
      redirect_to doctor_conversation_path(current_doctor, conversation)
    elsif patient_signed_in?
      recipients = Doctor.where(id: params['recipients'])
      conversation = current_patient.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
      flash[:success] = "Message has been sent!"
      redirect_to patient_conversation_path(current_patient, conversation)
    end
  end
end