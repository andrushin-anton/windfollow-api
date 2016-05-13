class Api::V1::AuthController < ApplicationController
	
	# POST /api/v1/auth/token
  # POST /api/v1/auth/token.json
  def token
  	@user = Api::V1::User.new(api_v1_user_params)
  	if @user.validate && @user = @user.authorize(params[:email], params[:password])
  		# Create a new token
  		render json: @user.generate_token
  	elsif @user.nil?
  		render json: '{"error":"invalid credentials"}', status: 401
  	else	
  		render json: @user.errors, status: :unprocessable_entity
  	end
  end

  private
    def api_v1_user_params
      params.permit(:email, :password)
    end
end
