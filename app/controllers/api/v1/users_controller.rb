class Api::V1::UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :update, :show]
  before_action :set_api_v1_user, only: [:show, :update, :destroy, :settings]
  before_action :update_last_activity!, only: [:index, :show, :settings]

  # GET /api/v1/users
  # GET /api/v1/users.json
  def index

    @api_v1_users = Api::V1::User.order('rating DESC').all
    
    unless params[:followers].nil?
      @api_v1_users = Api::V1::Follower.where('follower_id = ?', @current_user.id).all
    end

    unless params[:followings].nil?
      @api_v1_users = Api::V1::Following.where('user_id = ?', @current_user.id).all
    end

    unless params[:search].nil?
      @api_v1_users = Api::V1::User.where('first_name like :search or last_name like :search', search: "%#{params[:search]}%").all
    end

    paginate json: @api_v1_users
  end

  # GET /api/v1/users/1
  # GET /api/v1/users/1.json
  def show
    render json: @api_v1_user
  end

  # POST /api/v1/users
  # POST /api/v1/users.json
  def create
    @api_v1_user = Api::V1::User.new(api_v1_user_params)

    if @api_v1_user.save
      render json: @api_v1_user, status: :created, location: @api_v1_user
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/users/password_refresh
  def password_refresh
    @user = Api::V1::User.where('email = ?', params[:email]).first
    unless @user.nil?
      new_password = @user.password_refresh
      if @user.save
        # send new password to user
        SendEmailJob.set(wait: 10.seconds).perform_later(@user, new_password)

        render json: { message: 'password has been refreshed' }, status: 200
      else
        render json: { error: @user.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: 'email not found' }, status: 401
    end
  end

  # PATCH/PUT /api/v1/users/1
  # PATCH/PUT /api/v1/users/1.json
  def update
    head :no_content
    # @api_v1_user = Api::V1::User.find(params[:id])

    # if @api_v1_user.update(api_v1_user_params)
    #   head :no_content
    # else
    #   render json: @api_v1_user.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /api/v1/users/1/settings
  def settings
    if @api_v1_user.update(api_v1_user_settings_params)
      head :no_content
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  # DELETE /api/v1/users/1.json
  def destroy
    # @api_v1_user.destroy

    head :no_content
  end

  private

    def set_api_v1_user
      @api_v1_user = Api::V1::User.find(params[:id])
    end

    def api_v1_user_params
      params.permit(:email, :password, :first_name, :last_name)
    end

    def api_v1_user_settings_params
      params.permit(:wind, :temp)
    end
end
