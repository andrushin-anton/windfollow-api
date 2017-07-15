class Api::V1::SupportsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_api_v1_support, only: [:show, :update, :destroy]

  # GET /api/v1/supports
  # GET /api/v1/supports.json
  def index
    #@api_v1_supports = Api::V1::Support.all

    #render json: @api_v1_supports
  end

  # GET /api/v1/supports/1
  # GET /api/v1/supports/1.json
  def show
    #render json: @api_v1_support
  end

  # POST /api/v1/supports
  # POST /api/v1/supports.json
  def create
    @api_v1_support = Api::V1::Support.new(api_v1_support_params)
    @api_v1_support.details = {from: @current_user.id, name: @current_user.first_name + ' ' + @current_user.last_name}.to_json

    if @api_v1_support.save
      # send email to windfolow.com
      SendSupportEmailJob.set(wait: 10.seconds).perform_later(@current_user, @api_v1_support.message)
      
      render json: @api_v1_support, status: :created, location: @api_v1_support
    else
      render json: @api_v1_support.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/supports/1
  # PATCH/PUT /api/v1/supports/1.json
  def update
    #@api_v1_support = Api::V1::Support.find(params[:id])

    #if @api_v1_support.update(api_v1_support_params)
    #  head :no_content
    #else
    #  render json: @api_v1_support.errors, status: :unprocessable_entity
    #end
  end

  # DELETE /api/v1/supports/1
  # DELETE /api/v1/supports/1.json
  def destroy
    #@api_v1_support.destroy

    #head :no_content
  end

  private

    def set_api_v1_support
      @api_v1_support = Api::V1::Support.find(params[:id])
    end

    def api_v1_support_params
      params.permit(:message)
    end
end
