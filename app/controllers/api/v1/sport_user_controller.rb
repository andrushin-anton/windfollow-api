class Api::V1::SportUserController < ApplicationController
	before_filter :authenticate_user!

  # POST /api/v1/sport_user
  # POST /api/v1/sport_user.json
  def create
    @api_v1_sport = Api::V1::SportUser.new(api_v1_sport_params)
    @api_v1_sport.user_id = @current_user.id

    if @api_v1_sport.save
      head :created
    else
      render json: @api_v1_sport.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/sport_user/1
  # DELETE /api/v1/sport_user/1.json
  def destroy
  	@api_v1_sport = Api::V1::SportUser.where('sport_id =? and user_id =?', params[:sport_id], @current_user.id).first
  	if @api_v1_sport.destroy
      head :no_content
    else  
      render json: { error: 'not allowed' }, status: 401
    end
  end

  private

    def api_v1_sport_params
      params.permit(:sport_id)
    end
end
