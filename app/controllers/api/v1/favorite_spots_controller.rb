class Api::V1::FavoriteSpotsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_favorite_spot, only: [:destroy]

  # GET /api/v1/favorite_spots
  # GET /api/v1/favorite_spots.json
  def index
    @api_v1_favorite_spots = Api::V1::FavoriteSpot.where('user_id = ?', @current_user.id).all

    paginate json: @api_v1_favorite_spots
  end

  # GET /api/v1/favorite_spots/1
  # GET /api/v1/favorite_spots/1.json
  def show
    head :no_content
  end

  # POST /api/v1/favorite_spots
  # POST /api/v1/favorite_spots.json
  def create
    @api_v1_favorite_spot = Api::V1::FavoriteSpot.where('spot_id = ? AND user_id = ? ', params[:sport_id], @current_user.id).first

    if @api_v1_favorite_spot.nil?
      @api_v1_favorite_spot = Api::V1::FavoriteSpot.new(api_v1_favorite_spot_params)
      @api_v1_favorite_spot.user_id = @current_user.id
      
      if !@api_v1_favorite_spot.save
        render json: @api_v1_favorite_spot.errors, status: :unprocessable_entity
      else
        render json: @api_v1_favorite_spot, status: :created, location: @api_v1_favorite_spot
      end
    else
      head :no_content
    end
  end

  # PATCH/PUT /api/v1/favorite_spots/1
  # PATCH/PUT /api/v1/favorite_spots/1.json
  def update
    head :no_content
  end

  # DELETE /api/v1/favorite_spots/1
  # DELETE /api/v1/favorite_spots/1.json
  def destroy
    unless @api_v1_favorite_spot.nil?
      @api_v1_favorite_spot.destroy
    end

    head :no_content
  end

  private

    def set_api_v1_favorite_spot
      @api_v1_favorite_spot = Api::V1::FavoriteSpot.where('spot_id = ? AND user_id = ?', params[:id], @current_user.id).first
    end

    def api_v1_favorite_spot_params
      params.permit(:spot_id)
    end
end
