require 'date'

class Api::V1::ForecastController < ApplicationController

  # GET /api/v1/forecast/gfs/:lat/:lon
  # GET /api/v1/forecast/gfs.json
  def gfs
    # we need to get the last insert time
    rec = Api::V1::Gfs.order('rt desc').first

    unless rec.nil? && params[:lat] && params[:lon]
      # generate each hour list forecast for next 10 days
      hours_list = []
      date = rec.rt
      next_hour = DateTime.new(date.year, date.month, date.day, date.hour)
      hours_list << next_hour

      for i in 1..239
        date = date + 60*60 # +1 hour
        next_hour = DateTime.new(date.year, date.month, date.day, date.hour)
        hours_list << next_hour
      end


      #SELECT * FROM windfollow.gfs_2_5 where lat = -90 and lon = 0.25 and rt = '2016-08-06 12:00:00' and vt in('2016-08-06 13:00:00', '2016-08-06 14:00:00');
      @data = Api::V1::Gfs.where('lat = ? AND lon = ? AND rt = ? AND vt IN(?)', Api::V1::Gfs.interpolate_2_5(params[:lat]), Api::V1::Gfs.interpolate_2_5(params[:lon]), rec.rt, hours_list).all

      render json: @data, status: 200
    else
      head :no_content
    end
  end
end
