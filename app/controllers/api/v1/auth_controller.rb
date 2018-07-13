class Api::V1::AuthController < ApplicationController
	
	# POST /api/v1/auth/token
  # POST /api/v1/auth/token.json
  def token
    @user = Api::V1::User.where('email = ?', params[:email]).first
    unless @user.nil?
      if @user = @user.authorize(params[:email], params[:password])
        # Create a new token
        render json: @user.generate_token
      elsif @user.nil?
        render json: { error: 'Invalid credentials' }, status: 401
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'User not found' }, status: 404
    end
  end

  # POST /api/v1/auth/token/facebook
  # POST /api/v1/auth/token/facebook.json
  def facebook
    @user = Api::V1::User.where('email = ?', params[:email]).first
    unless @user.nil?
      # Create a new token
      render json: @user.generate_token
    else
      @api_v1_user = Api::V1::User.new(:email => params[:email], :password => params[:id], :first_name => params[:first_name], :last_name => params[:last_name])
      if @api_v1_user.save
        render json: @api_v1_user.generate_token
      else
        render json: @api_v1_user.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def api_v1_user_params
      params.permit(:email, :password, :id, :first_name, :last_name)
    end
end
