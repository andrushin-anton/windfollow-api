require 'date'

class Api::V1::ForecastController < ApplicationController
  #before_filter :authenticate_user!, only: [:gfs]

  # GET /api/v1/forecast/gfs/:lat/:lon
  # GET /api/v1/forecast/gfs.json
  def gfs
    unless params[:lat] && params[:lon]
      unless @current_user.nil?
        current_temp = @current_user.temp
        current_wind = @current_user.wind  
      else 
        current_temp = 'c'
        current_wind = 'm/s'  
      end 

      data = Api::V1::Gfs.find_data_by_coordinates(params[:lat], params[:lon], current_temp, current_wind)

      unless data.nil?
        render json: data, status: 200
      else
        head :no_content    
      end
    else
      head :no_content
    end
  end
end
