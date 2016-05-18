class Api::V1::SportsController < ApplicationController
  before_action :set_api_v1_sport, only: [:show, :update, :destroy]

  # GET /api/v1/sports
  # GET /api/v1/sports.json
  def index
    @api_v1_sports = Api::V1::Sport.all

    render json: @api_v1_sports
  end

  # GET /api/v1/sports/1
  # GET /api/v1/sports/1.json
  def show
    render json: @api_v1_sport
  end

  # POST /api/v1/sports
  # POST /api/v1/sports.json
  def create
    @api_v1_sport = Api::V1::Sport.new(api_v1_sport_params)

    if @api_v1_sport.save
      render json: @api_v1_sport, status: :created, location: @api_v1_sport
    else
      render json: @api_v1_sport.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/sports/1
  # PATCH/PUT /api/v1/sports/1.json
  def update
    @api_v1_sport = Api::V1::Sport.find(params[:id])

    if @api_v1_sport.update(api_v1_sport_params)
      head :no_content
    else
      render json: @api_v1_sport.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/sports/1
  # DELETE /api/v1/sports/1.json
  def destroy
    @api_v1_sport.destroy

    head :no_content
  end

  private

    def set_api_v1_sport
      @api_v1_sport = Api::V1::Sport.find(params[:id])
    end

    def api_v1_sport_params
      params.permit(:name)
    end
end
