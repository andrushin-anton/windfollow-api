class Api::V1::MessagesController < ApplicationController
  before_action :set_api_v1_message, only: [:show, :update, :destroy]

  # GET /api/v1/messages
  # GET /api/v1/messages.json
  def index
    @api_v1_messages = Api::V1::Message.all

    render json: @api_v1_messages
  end

  # GET /api/v1/messages/1
  # GET /api/v1/messages/1.json
  def show
    render json: @api_v1_message
  end

  # POST /api/v1/messages
  # POST /api/v1/messages.json
  def create
    @api_v1_message = Api::V1::Message.new(api_v1_message_params)

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

    if @api_v1_message.update(api_v1_message_params)
      head :no_content
    else
      render json: @api_v1_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/messages/1
  # DELETE /api/v1/messages/1.json
  def destroy
    @api_v1_message.destroy

    head :no_content
  end

  private

    def set_api_v1_message
      @api_v1_message = Api::V1::Message.find(params[:id])
    end

    def api_v1_message_params
      params.require(:api_v1_message).permit(:sender_id, :recepient_id, :content)
    end
end
