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
  
    # Save last known user's geo location
    if !params[:geo_lat].nil? && !params[:geo_lon].nil?
      @current_user.geo_lat = params[:geo_lat]
      @current_user.geo_lon = params[:geo_lon]
      @current_user.save
    end

    @api_v1_device = Api::V1::Device.where('token = ? AND user_id = ? ', params[:token], @current_user.id).first

    if @api_v1_device.nil?
      @api_v1_device = Api::V1::Device.new(api_v1_device_params)   
      @api_v1_device.user_id = @current_user.id   
      
      if !@api_v1_device.save
        render json: @api_v1_device.errors, status: :unprocessable_entity
      else
        head :no_content
      end
    else
      head :no_content
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
