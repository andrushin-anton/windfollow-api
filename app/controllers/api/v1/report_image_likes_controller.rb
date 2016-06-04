class Api::V1::ReportImageLikesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_report_image_like, only: [:show, :update, :destroy]

  # GET /api/v1/report_image_likes
  # GET /api/v1/report_image_likes.json
  def index
    @api_v1_report_image_likes = Api::V1::ReportImageLike.all

    paginate json: @api_v1_report_image_likes
  end

  # GET /api/v1/report_image_likes/1
  # GET /api/v1/report_image_likes/1.json
  def show
    head :not_found
  end

  # GET /api/v1/report_images/1/likes
  # GET /api/v1/report_images/1/likes.json
  def likes
    paginate json: Api::V1::ReportImageLike.where('report_image_id = ?', params[:id])
  end

  # POST /api/v1/report_image_likes
  # POST /api/v1/report_image_likes.json
  def create
    @api_v1_report_image_like = Api::V1::ReportImageLike.new(api_v1_report_image_like_params)
    @api_v1_report_image_like.user_id = @current_user.id

    if @api_v1_report_image_like.save
      render json: @api_v1_report_image_like, status: :created, location: @api_v1_report_image_like
    else
      render json: @api_v1_report_image_like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/report_image_likes/1
  # PATCH/PUT /api/v1/report_image_likes/1.json
  def update
    head :no_content
    # @api_v1_report_image_like = Api::V1::ReportImageLike.find(params[:id])

    # if @api_v1_report_image_like.update(api_v1_report_image_like_params)
    #   head :no_content
    # else
    #   render json: @api_v1_report_image_like.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /api/v1/report_image_likes/1
  # DELETE /api/v1/report_image_likes/1.json
  def destroy
    unless @api_v1_report_image_like.nil?
      @api_v1_report_image_like.destroy
    end
    head :no_content
  end

  private

    def set_api_v1_report_image_like
      @api_v1_report_image_like = Api::V1::ReportImageLike.where('report_image_id = ? AND user_id = ?', params[:id], @current_user.id).first
    end

    def api_v1_report_image_like_params
      params.permit(:report_image_id)
    end
end
