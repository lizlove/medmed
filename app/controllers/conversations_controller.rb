class ConversationsController < ApplicationController
  def authenticate_user!
    return if doctor_signed_in?
    return if patient_signed_in?
  end
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end
   
  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def show
  end
 
  def index
    @conversations = (@mailbox.inbox | @mailbox.sentbox).sort_by{|convo|convo.updated_at}.reverse
  end

  def reply
    if doctor_signed_in?
      current_doctor.reply_to_conversation(@conversation, params[:body])
      flash[:success] = 'Reply sent'
      redirect_to doctor_conversation_path(current_doctor, @conversation)
    elsif patient_signed_in?
      current_patient.reply_to_conversation(@conversation, params[:body])
      flash[:success] = 'Reply sent'
      redirect_to patient_conversation_path(current_patient, @conversation)
    end
  end
 
  private
 
  def get_conversation
    @conversation = @mailbox.conversations.find(params[:id])
  end
 
  def get_mailbox
    if doctor_signed_in?
      @mailbox = current_doctor.mailbox
    elsif patient_signed_in?
      @mailbox = current_patient.mailbox
    end
  end
end