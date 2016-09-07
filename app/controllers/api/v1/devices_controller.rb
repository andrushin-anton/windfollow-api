class Api::V1::DevicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_device, only: [:show, :update, :destroy]

  # GET /api/v1/devices
  # GET /api/v1/devices.json
  def index
    head :no_content
  end

  # GET /api/v1/devices/1
  # GET /api/v1/devices/1.json
  def show
    head :no_content
  end

  # POST /api/v1/devices
  # POST /api/v1/devices.json
  def create
    unless params[:token].nil?
      Api::V1::Device.where('token = ?', params[:token]).destroy_all
    end

    @api_v1_device = Api::V1::Device.new(api_v1_device_params)
    @api_v1_device.user_id = @current_user.id

    if @api_v1_device.save
      render json: @api_v1_device, status: :created, location: @api_v1_device
    else
      render json: @api_v1_device.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/devices/1
  # PATCH/PUT /api/v1/devices/1.json
  def update
    head :no_content
  end

  # DELETE /api/v1/devices/1
  # DELETE /api/v1/devices/1.json
  def destroy
    head :no_content
  end

  private

    def set_api_v1_device
      @api_v1_device = Api::V1::Device.find(params[:id])
    end

    def api_v1_device_params
      params.permit(:name, :token)
    end
end
