class Api::V1::ReportsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_report, only: [:show, :update, :destroy]

  # GET /api/v1/reports
  # GET /api/v1/reports.json
  def index
    followings = Api::V1::Follower.where('follower_id = ?', @current_user.id).all
    favorite_spots = Api::V1::FavoriteSpot.where('user_id = ?', @current_user.id).all

    @api_v1_reports = Api::V1::Report.where('user_id IN(?) OR spot_id IN(?) OR user_id = ?', followings.map(&:user_id), favorite_spots.map(&:spot_id), @current_user.id).order('created_at desc').all

    paginate json: @api_v1_reports
  end

  # GET /api/v1/posts
  # GET /api/v1/posts.json
  def posts
    followings = Api::V1::Follower.where('follower_id = ?', @current_user.id).all
    favorite_spots = Api::V1::FavoriteSpot.where('user_id = ?', @current_user.id).all

    @api_v1_reports = Api::V1::Report.where('direction IS NULL AND (user_id IN(?) OR spot_id IN(?) OR user_id = ?)', followings.map(&:user_id), favorite_spots.map(&:spot_id), @current_user.id).order('created_at desc').all

    paginate json: @api_v1_reports
  end

  # GET /api/v1/feed
  # GET /api/v1/feed.json
  def feed
    @api_v1_reports = Api::V1::Report.where('user_id = ?', @current_user.id).order('created_at desc').all

    paginate json: @api_v1_reports
  end

  # GET /api/v1/reports/1
  # GET /api/v1/reports/1.json
  def show
    render json: @api_v1_report
  end

  # POST /api/v1/reports
  # POST /api/v1/reports.json
  def create
    @api_v1_report = Api::V1::Report.new(api_v1_report_params)
    @api_v1_report.user_id = @current_user.id

    if @api_v1_report.save
      render json: @api_v1_report, status: :created, location: @api_v1_report
    else
      render json: @api_v1_report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/reports/1
  # PATCH/PUT /api/v1/reports/1.json
  def update
    @api_v1_report = Api::V1::Report.find(params[:id])

    if @api_v1_report.user_id == @current_user.id && @api_v1_report.update(api_v1_report_params)
      head :no_content
    else
      render json: @api_v1_report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/reports/1
  # DELETE /api/v1/reports/1.json
  def destroy
    if @api_v1_report.user_id == @current_user.id && @api_v1_report.destroy
      head :no_content
    else
      render json: { error: 'not allowed' }, status: 401
    end
  end

  private

    def set_api_v1_report
      @api_v1_report = Api::V1::Report.find(params[:id])
    end

    def api_v1_report_params
      params.permit(:spot_id, :content, :place, :wind, :direction)
    end
end
