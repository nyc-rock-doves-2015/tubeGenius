class ConversationsController < ApplicationController
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]

  def show
  end

  def index
    @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to conversation_path(@conversation)
  end

  private

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
end
