class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_action do
   @conversation = Api::V1::Conversation.where('id = ? AND (sender_id = ? OR recipient_id = ?)', params[:conversation_id], @current_user.id, @current_user.id).first
   if @conversation.nil?
    render json: { error: 'wrong conversation' }, status: 404
   end    
  end

  # GET /api/v1/conversations/:id/messages
  # GET /api/v1/conversations/:id/messages.json
  def index
    messages = @conversation.messages.order('created_at DESC')

    messages.each do |m|
      if m.user_id != @current_user.id
        m.read = true;
        m.save
      end
    end
    
    paginate json: messages
  end

  # POST /api/v1/conversations/:id/messages
  # POST /api/v1/conversations/:id/messages.json
  def create
    message = @conversation.messages.new(message_params)
    message.user_id = @current_user.id
    if message.save
      render json: message, status: :created, location: message
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end

  private
    def message_params
      params.permit(:body)
    end
end
