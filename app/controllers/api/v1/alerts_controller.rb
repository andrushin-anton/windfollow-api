class Api::V1::AlertsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_alert, only: [:show, :update, :destroy]

  # GET /api/v1/alerts
  # GET /api/v1/alerts.json
  def index
    @api_v1_alerts = Api::V1::Alert.where('user_id = ?', @current_user.id).all

    paginate json: @api_v1_alerts
  end

  # POST /api/v1/alerts
  # POST /api/v1/alerts.json
  def create
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
      @api_v1_alert = Api::V1::Alert.where('id = ? AND user_id = ?', params[:id], @current_user.id).first
    end

    def api_v1_alert_params
      params.permit(:notify_for_days, :sensor_enabled, :speed_from, :speed_to, :direction, :spot_id, :distance, :time_alert)
    end
end
