class Api::V1::ReportsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_report, only: [:show, :update, :destroy]

  # GET /api/v1/reports
  # GET /api/v1/reports.json
  def index
    @api_v1_reports = Api::V1::Report.all

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
