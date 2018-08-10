class Api::V1::FollowingsController < ApplicationController
  before_filter :authenticate_user!

  # GET /api/v1/followings
  # GET /api/v1/followings.json
  def index
    head 404
    # @api_v1_followings = Api::V1::Following.all

    # render json: @api_v1_followings
  end

  # GET /api/v1/followings/1
  # GET /api/v1/followings/1.json
  def show
    user = Api::V1::User.find(params[:id])
    unless user.nil?
      render json: user.followings.all
    end
  end

  # POST /api/v1/followings
  # POST /api/v1/followings.json
  def create
    head 404
    # @api_v1_following = Api::V1::Following.new(api_v1_following_params)
    # @api_v1_follower.following_id = @current_user.id

    # if @api_v1_following.save
    #   render json: @api_v1_following, status: :created, location: @api_v1_following
    # else
    #   render json: @api_v1_following.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /api/v1/followings/1
  # PATCH/PUT /api/v1/followings/1.json
  def update
    head 404
    # @api_v1_following = Api::V1::Following.find(params[:id])

    # if @api_v1_following.update(api_v1_following_params)
    #   head :no_content
    # else
    #   render json: @api_v1_following.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /api/v1/followings/1
  # DELETE /api/v1/followings/1.json
  def destroy
    head 404
    # @api_v1_following = Api::V1::Follower.where('following_id =? and user_id =?', @current_user.id, params[:id]).first
    # if @api_v1_following.destroy
    #   head :no_content
    # else  
    #   render json: { error: 'not allowed' }, status: 401
    # end
  end

  private

    def api_v1_following_params
      params.permit(:user_id)
    end
end
