class Api::V1::ProfileController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_api_v1_user

	# PATCH/PUT /api/v1/profile
  # PATCH/PUT /api/v1/profile.json
  def update
    if @api_v1_user.update(api_v1_user_params)
      head :no_content
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  private

    def set_api_v1_user
      @api_v1_user = Api::V1::User.find(@current_user.id)
    end

    def api_v1_user_params
      params.permit(:first_name, :last_name, :image, :about, :birth_date, :gender, :phone, :web_site, :place)
    end
end
