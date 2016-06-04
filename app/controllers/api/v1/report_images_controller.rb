class Api::V1::ReportImagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_report_image, only: [:show, :update, :destroy]

  # GET /api/v1/report_images
  # GET /api/v1/report_images.json
  def index
    @api_v1_report_images = Api::V1::ReportImage.all.recent

    paginate json: @api_v1_report_images
  end

  # GET /api/v1/report_images/1
  # GET /api/v1/report_images/1.json
  def show
    render json: @api_v1_report_image
  end

  # GET /api/v1/reports/1/images
  # GET /api/v1/reports/1/images.json
  def images
    paginate json: Api::V1::ReportImage.where('report_id = ?', params[:id]).recent
  end

  # GET /api/v1/users/1/images
  # GET /api/v1/users/1/images.json
  def uimages
    paginate json: Api::V1::ReportImage.where('user_id = ?', params[:id]).recent
  end

  # POST /api/v1/report_images
  # POST /api/v1/report_images.json
  def create
    @api_v1_report_image = Api::V1::ReportImage.new(api_v1_report_image_params)
    @api_v1_report_image.user_id = @current_user.id

    if @api_v1_report_image.save
      render json: @api_v1_report_image, status: :created, location: @api_v1_report_image
    else
      render json: @api_v1_report_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/report_images/1
  # PATCH/PUT /api/v1/report_images/1.json
  def update
    head :not_found
    # @api_v1_report_image = Api::V1::ReportImage.find(params[:id])

    # if @api_v1_report_image.update(api_v1_report_image_params)
    #   head :no_content
    # else
    #   render json: @api_v1_report_image.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /api/v1/report_images/1
  # DELETE /api/v1/report_images/1.json
  def destroy
    if @current_user.id == @api_v1_report_image.user_id && @api_v1_report_image.destroy
      head :no_content
    else
      render json: { error: 'not allowed' }, status: 401
    end
  end

  private

    def set_api_v1_report_image
      @api_v1_report_image = Api::V1::ReportImage.find(params[:id])
    end

    def api_v1_report_image_params
      params.permit(:report_id, :image)
    end
end
