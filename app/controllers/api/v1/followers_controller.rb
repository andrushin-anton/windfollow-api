class Api::V1::FollowersController < ApplicationController
  before_filter :authenticate_user!

  # GET /api/v1/followers
  # GET /api/v1/followers.json
  def index
    head 404
    # @api_v1_followers = Api::V1::Follower.all

    # render json: @api_v1_followers
  end

  # GET /api/v1/followers/1
  # GET /api/v1/followers/1.json
  def show
    user = Api::V1::User.find(params[:id])
    unless user.nil?
      render json: user.followers.all
    end
  end

  # POST /api/v1/followers
  # POST /api/v1/followers.json
  def create
    @api_v1_follower = Api::V1::Follower.new(api_v1_follower_params)
    @api_v1_follower.follower_id = @current_user.id
    @api_v1_follower.user_id = params[:user_id]

    if @api_v1_follower.save

      # create new notification
      notification = Api::V1::Notification.new
      notification.user_id = @api_v1_follower.user_id
      notification.event_type = Api::V1::Notification::TYPE_NEW_FOLLOWER
      notification.content = { :event_user_id => @current_user.id, :event_user_name => @current_user.first_name + ' ' + @current_user.last_name, :event_user_avatar => @current_user.formated_avatar }.to_json
      notification.event_object_id = @api_v1_follower.user_id
      notification.save

      render json: @api_v1_follower, status: :created, location: @api_v1_follower
    else
      render json: @api_v1_follower.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/followers/1
  # PATCH/PUT /api/v1/followers/1.json
  def update
    head 404
    # @api_v1_follower = Api::V1::Follower.find(params[:id])

    # if @api_v1_follower.update(api_v1_follower_params)
    #   head :no_content
    # else
    #   render json: @api_v1_follower.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /api/v1/followers/1
  # DELETE /api/v1/followers/1.json
  def destroy
    @api_v1_follower = Api::V1::Follower.where('follower_id =? and user_id =?', @current_user.id, params[:id]).first
    if @api_v1_follower.destroy
      head :no_content
    else  
      render json: { error: 'not allowed' }, status: 401
    end
  end

  private

    def api_v1_follower_params
      params.permit(:user_id)
    end
end
