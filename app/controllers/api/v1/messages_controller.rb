class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_message, only: [:show, :update, :destroy]

  # GET /api/v1/messages
  # GET /api/v1/messages.json
  def index
    render json: Api::V1::Message.select('distinct(recepient_id), id, sender_id, recepient_id, content, created_at, updated_at').filter_by_user(@current_user.id)
  end

  # GET /api/v1/messages/1/recepient
  # GET /api/v1/messages/1/recepient.json
  def recepient
    paginate json: Api::V1::Message.filter_by_user(@current_user.id).filter_by_recepient(params[:id]).recent
  end

  # GET /api/v1/messages/1
  # GET /api/v1/messages/1.json
  def show
    if @api_v1_message.sender_id == @current_user.id
      render json: @api_v1_message
    else
      render json: { error: 'not found' }, status: 404
    end
  end

  # POST /api/v1/messages
  # POST /api/v1/messages.json
  def create
    @api_v1_message = Api::V1::Message.new(api_v1_message_params)
    @api_v1_message.sender_id = @current_user.id

    if @api_v1_message.save
      render json: @api_v1_message, status: :created, location: @api_v1_message
    else
      render json: @api_v1_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/messages/1
  # PATCH/PUT /api/v1/messages/1.json
  def update
    @api_v1_message = Api::V1::Message.find(params[:id])

    if @api_v1_message.sender_id == @current_user.id && @api_v1_message.update(api_v1_message_params)
      head :no_content
    else
      render json: @api_v1_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/messages/1
  # DELETE /api/v1/messages/1.json
  def destroy
    if @api_v1_message.sender_id == @current_user.id && @api_v1_message.destroy
      head :no_content
    else  
      render json: { error: 'not allowed' }, status: 401
    end    
  end

  private

    def set_api_v1_message
      @api_v1_message = Api::V1::Message.find(params[:id])
    end

    def api_v1_message_params
      params.permit(:recepient_id, :content)
    end
end
