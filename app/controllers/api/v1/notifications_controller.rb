class Api::V1::NotificationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_notification, only: [:show, :update, :destroy]

  # GET /api/v1/notifications
  # GET /api/v1/notifications.json
  def index
    @api_v1_notifications = Api::V1::Notification.where('user_id = ?', @current_user.id).all

    paginate json: @api_v1_notifications
  end

  # GET /api/v1/notifications/1
  # GET /api/v1/notifications/1.json
  def show
    render json: @api_v1_notification
  end

  # POST /api/v1/notifications
  # POST /api/v1/notifications.json
  def create
    head :not_found
  end

  # PATCH/PUT /api/v1/notifications/1
  # PATCH/PUT /api/v1/notifications/1.json
  def update
    head :not_found
  end

  # DELETE /api/v1/notifications/1
  # DELETE /api/v1/notifications/1.json
  def destroy
    @api_v1_notification.destroy
    
    head :no_content
  end

  private

    def set_api_v1_notification
      @api_v1_notification = Api::V1::Notification.where('user_id = ? AND id = ?', @current_user.id, params[:id]).first
    end
end
