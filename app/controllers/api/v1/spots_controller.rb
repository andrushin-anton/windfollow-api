class Api::V1::SpotsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_spot, only: [:show, :update, :destroy]

  # GET /api/v1/spots
  # GET /api/v1/spots.json
  def index
    @api_v1_spots = Api::V1::Spot.all

    unless params[:search].nil?
      @api_v1_spots = Api::V1::Spot.where('name like :search or country like :search or city like :search', search: "%#{params[:search]}%").all
    end

    unless params[:wave].nil?
      @api_v1_spots = Api::V1::Spot.where('wave like :wave', wave: "%#{params[:wave]}%").all
    end

    unless params[:level].nil?
      @api_v1_spots = Api::V1::Spot.where('level like :level', level: "%#{params[:level]}%").all
    end

    unless params[:sport].nil?
      @api_v1_spots = Api::V1::Spot.where('sport like :sport', sport: "%#{params[:sport]}%").all
    end

    unless params[:best_month].nil?
      @api_v1_spots = Api::V1::Spot.where('best_month like :best_month', best_month: "%#{params[:best_month]}%").all
    end

    unless params[:rating].nil?
      @api_v1_spots = Api::V1::Spot.where('rating like :rating', rating: "%#{params[:rating]}%").all
    end

    unless params[:country].nil?
      @api_v1_spots = Api::V1::Spot.where('country like :country', country: "%#{params[:country]}%").all
    end

    paginate json: @api_v1_spots
  end

  # GET /api/v1/spots/1
  # GET /api/v1/spots/1.json
  def show
    render json: @api_v1_spot
  end

  # POST /api/v1/spots
  # POST /api/v1/spots.json
  def create
    @api_v1_spot = Api::V1::Spot.new(api_v1_spot_params)
    @api_v1_spot.user_id = @current_user.id

    if @api_v1_spot.save
      render json: @api_v1_spot, status: :created, location: @api_v1_spot
    else
      render json: @api_v1_spot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/spots/1
  # PATCH/PUT /api/v1/spots/1.json
  def update
    if @api_v1_spot.user_id == @current_user.id && @api_v1_spot.update(api_v1_spot_params)
      head :no_content
    else
      render json: @api_v1_spot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/spots/1
  # DELETE /api/v1/spots/1.json
  def destroy
    if @api_v1_spot.user_id == @current_user.id && @api_v1_spot.destroy
      head :no_content
    else
      render json: { error: 'not allowed' }, status: 401
    end
  end

  private

    def set_api_v1_spot
      @api_v1_spot = Api::V1::Spot.find(params[:id])
    end

    def api_v1_spot_params
      params.permit(:name, :geo_lat, :geo_lon, :rating, :best_month, :wave, :level, :user_id, :place, :sport)
    end
end
