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
    @conversations = (@mailbox.inbox | @mailbox.sentbox).sort_by{ |convo| convo.updated_at }.reverse
  end

  def reply
    umn = user_model_name
    send("current_#{umn}").reply_to_conversation(@conversation, params[:body])
    redir_url = send("#{umn}_conversation_path", send("current_#{umn}"), @conversation)
    flash[:success] = 'Reply sent'
    redirect_to redir_url
  end
 
  private
 
  def get_conversation
    @conversation = @mailbox.conversations.find(params[:id])
  end
 
  def get_mailbox
    umn = user_model_name
    @mailbox = send("current_#{umn}").mailbox
  end

  def user_model_name
    if doctor_signed_in?
      "doctor"
    elsif patient_signed_in?
      "patient"
    end
  end
end