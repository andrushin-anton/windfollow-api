class Api::V1::SpotsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_spot, only: [:show, :update, :destroy]
  before_action :update_last_activity!, only: [:index, :feed, :show, :create, :update]

  # GET /api/v1/spots
  # GET /api/v1/spots.json
  def index
    query_params = {}
    order = ''
    where = ''
    # Sort by nearest to user
    unless @current_user.geo_lat.nil?
      order = "(POW((geo_lon - #{@current_user.geo_lon}),2) + POW((geo_lat - #{@current_user.geo_lat}),2))"
    else
      order = "rating DESC" 
    end

    unless params[:search].nil?
      where = 'name like :search or country like :search or city like :search'
      query_params[:search] = "%#{params[:search]}%"
    end

    unless params[:wave].nil?
      if where == '' then where = 'wave like :wave' else where = where + ' AND wave like :wave' end
      query_params[:wave] = "%#{params[:wave]}%"
    end

    unless params[:level].nil?
      if where == '' then where = 'level like :level' else where = where + ' AND level like :level' end
      query_params[:level] = "%#{params[:level]}%"
    end

    unless params[:sport].nil?
      if where == '' then where = 'sport like :sport' else where = where + ' AND sport like :sport' end
      query_params[:sport] = "%#{params[:sport]}%"
    end

    unless params[:best_month].nil?
      if where == '' then where = 'best_month like :best_month' else where = where + ' AND best_month like :best_month' end
      query_params[:best_month] = "%#{params[:best_month]}%"
    end

    unless params[:rating].nil?
      if where == '' then where = 'rating like :rating' else where = where + ' AND rating like :rating' end
      query_params[:rating] = "%#{params[:rating]}%"
    end

    unless params[:country].nil?
      if where == '' then where = 'country like :country' else where = where + ' AND country like :country' end
      query_params[:country] = "%#{params[:country]}%"
    end

    if where == ''
      @api_v1_spots = Api::V1::Spot.where('active = 1').order(order).all
    else
      where = where + ' AND active = 1'
      @api_v1_spots = Api::V1::Spot.where(where, query_params).order(order).all
    end

    paginate json: @api_v1_spots
  end

  # GET /api/v1/spots/1
  # GET /api/v1/spots/1.json
  def show
    render json: @api_v1_spot
  end

  # GET /api/v1/spots/1/feed
  # GET /api/v1/spots/1/feed.json
  def feed
    @api_v1_reports = Api::V1::Report.where('spot_id = ?', params[:id]).order('created_at desc').all

    paginate json: @api_v1_reports
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

  # DELETE /api/v1/spots/unsubscribe/1
  # DELETE /api/v1/spots/unsubscribe/1.json
  def unsubscribe
    user_spot = Api::V1::UserSpot.where('spot_id = ? AND user_id = ? ', params[:id], @current_user.id).first

    unless user_spot.nil?
      user_spot.destroy
    end

    head :no_content
  end

  private

    def set_api_v1_spot
      @api_v1_spot = Api::V1::Spot.where('id = ? AND active = 1', params[:id]).first
    end

    def api_v1_spot_params
      params.permit(:name, :geo_lat, :geo_lon, :rating, :best_month, :wave, :level, :user_id, :place, :sport)
    end
end
