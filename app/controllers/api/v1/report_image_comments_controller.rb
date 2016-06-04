class Api::V1::ReportImageCommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_report_image_comment, only: [:show, :update, :destroy]

  # GET /api/v1/report_image_comments
  # GET /api/v1/report_image_comments.json
  def index
    @api_v1_report_image_comments = Api::V1::ReportImageComment.all

    paginate json: @api_v1_report_image_comments.recent
  end

  # GET /api/v1/report_images/1/comments
  # GET /api/v1/report_images/1/comments.json
  def comments
    paginate json: Api::V1::ReportImageComment.where('report_image_id = ?', params[:id]).recent
  end

  # GET /api/v1/report_image_comments/1
  # GET /api/v1/report_image_comments/1.json
  def show
    render json: @api_v1_report_image_comment
  end

  # POST /api/v1/report_image_comments
  # POST /api/v1/report_image_comments.json
  def create
    @api_v1_report_image_comment = Api::V1::ReportImageComment.new(api_v1_report_image_comment_params)
    @api_v1_report_image_comment.user_id = @current_user.id

    if @api_v1_report_image_comment.save
      render json: @api_v1_report_image_comment, status: :created, location: @api_v1_report_image_comment
    else
      render json: @api_v1_report_image_comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/report_image_comments/1
  # PATCH/PUT /api/v1/report_image_comments/1.json
  def update
    @api_v1_report_image_comment = Api::V1::ReportImageComment.find(params[:id])

    if @api_v1_report_image_comment.user_id == @current_user.id && @api_v1_report_image_comment.update(api_v1_report_image_comment_params)
      head :no_content
    else
      render json: @api_v1_report_image_comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/report_image_comments/1
  # DELETE /api/v1/report_image_comments/1.json
  def destroy
    if @api_v1_report_image_comment.user_id == @current_user.id && @api_v1_report_image_comment.destroy
      head :no_content
    else
      render json: { error: 'not allowed' }, status: 401
    end
  end

  private

    def set_api_v1_report_image_comment
      @api_v1_report_image_comment = Api::V1::ReportImageComment.find(params[:id])
    end

    def api_v1_report_image_comment_params
      params.permit(:report_image_id, :content)
    end
end
