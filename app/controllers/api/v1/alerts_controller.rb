class Api::V1::AlertsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_alert, only: [:show, :update, :destroy]

  # GET /api/v1/alerts
  # GET /api/v1/alerts.json
  def index
    @api_v1_alerts = Api::V1::Alert.where('user_id = ?', @current_user.id).first

    render json: @api_v1_alerts
  end

  # POST /api/v1/alerts
  # POST /api/v1/alerts.json
  def create
    # delete all prev alerts if exists
    alert = Api::V1::Alert.where('user_id = ?', @current_user.id).first
    unless alert.nil?
      alert.destroy
    end

    @api_v1_alert = Api::V1::Alert.new(api_v1_alert_params)
    @api_v1_alert.user_id = @current_user.id

    if @api_v1_alert.save
      render json: @api_v1_alert, status: :created, location: @api_v1_alert
    else
      render json: @api_v1_alert.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/alerts/1
  # PATCH/PUT /api/v1/alerts/1.json
  def update
    @api_v1_alert = Api::V1::Alert.find(params[:id])

    if @api_v1_alert.update(api_v1_alert_params)
      head :no_content
    else
      render json: @api_v1_alert.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/alerts/1
  # DELETE /api/v1/alerts/1.json
  def destroy
    @api_v1_alert.destroy

    head :no_content
  end

  private

    def set_api_v1_alert
      @api_v1_alert = Api::V1::Alert.find(params[:id])
    end

    def api_v1_alert_params
      params.permit(:distance, :time_alert)
    end
end
