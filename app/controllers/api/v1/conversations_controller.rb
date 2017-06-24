class Api::V1::ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :update_last_activity!, only: [:index]
  
  # GET /api/v1/conversations
  # GET /api/v1/conversations
  def index
    conversations = Api::V1::Conversation.where('sender_id = ? OR recipient_id = ?', @current_user.id, @current_user.id).order('updated_at DESC').all
    
    paginate json: conversations
  end

  # GET /api/v1/messages/:user_id/recipient
  # GET /api/v1/messages/:user_id/recipient.json
  def recipient
    conversation = Api::V1::Conversation.between(@current_user.id, params[:user_id]).first

    unless conversation.nil?
      messages = conversation.messages.order('created_at DESC')

      paginate json: messages
    else
      paginate json: []
    end
  end

  # POST /api/v1/conversations
  # POST /api/v1/conversations.json
  def create
    if Api::V1::Conversation.between(@current_user.id, params[:recipient_id]).present?
        conversation = Api::V1::Conversation.between(@current_user.id, params[:recipient_id]).first
    else
      conversation = Api::V1::Conversation.new(conversation_params)
      conversation.sender_id = @current_user.id
      conversation.save
    end
    render json: conversation
  end

  private
    def conversation_params
      params.permit(:recipient_id)
    end
end
