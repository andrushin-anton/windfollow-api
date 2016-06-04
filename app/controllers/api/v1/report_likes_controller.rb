class Api::V1::ReportLikesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_report_like, only: [:show, :update, :destroy]

  # GET /api/v1/report_likes
  # GET /api/v1/report_likes.json
  def index
    @api_v1_report_likes = Api::V1::ReportLike.all

    paginate json: @api_v1_report_likes
  end

  # GET /api/v1/report_likes/1
  # GET /api/v1/report_likes/1.json
  def show
    head :not_found
    #render json: @api_v1_report_like
  end

  # GET /api/v1/reports/1/likes
  # GET /api/v1/report/1/likes.json
  def likes
    paginate json: Api::V1::ReportLike.where('report_id = ?', params[:id])
  end


  # POST /api/v1/report_likes
  # POST /api/v1/report_likes.json
  def create
    @api_v1_report_like = Api::V1::ReportLike.where('report_id = ? AND user_id = ? ', params[:report_id], @current_user.id).first_or_create do |like|
      like.report_id = params[:report_id]
      like.user_id = @current_user.id
    end
    render json: @api_v1_report_like, status: :created, location: @api_v1_report_like
  end

  # PATCH/PUT /api/v1/report_likes/1
  # PATCH/PUT /api/v1/report_likes/1.json
  def update
    head :no_content
    # @api_v1_report_like = Api::V1::ReportLike.find(params[:id])

    # if @api_v1_report_like.update(api_v1_report_like_params)
    #   head :no_content
    # else
    #   render json: @api_v1_report_like.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /api/v1/report_likes/1
  # DELETE /api/v1/report_likes/1.json
  def destroy
    unless condition
      @api_v1_report_like.destroy
    end
    head :no_content
  end

  private

    def set_api_v1_report_like
      @api_v1_report_like = Api::V1::ReportLike.where('report_id = ? AND user_id = ?', params[:id], @current_user.id).first
    end

    def api_v1_report_like_params
      params.permit(:report_id)
    end
end
