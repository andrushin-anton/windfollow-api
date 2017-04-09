class Api::V1::SensorsController < ApplicationController

  def nearest
    @spot = Api::V1::Spot.where('id = ?', params[:spot]).first
    unless @spot.nil?
      # get sensors ordered by geo coordinates nearest to given
      sensors = Api::V1::Sensor.order("(POW((geo_lon - #{@spot.geo_lon}),2) + POW((geo_lat - #{@spot.geo_lat}),2))").all
      sensors_within_10_km = []

      sensors.each do |sensor|
        distance = Api::V1::Report.haversine(@spot.geo_lat.to_f, @spot.geo_lon.to_f, sensor.geo_lat.to_f, sensor.geo_lon.to_f)
        if distance <= 10
          sensors_within_10_km << sensor
        end
      end
      
      render json: sensors_within_10_km
    else 
      render json: { error: 'spot not found' }, status: 404
    end
  end

  def get
    @sensor = Api::V1::Sensor.where('slug = ?', params[:slug]).first
    unless @sensor.nil?
      render json: @sensor      
    else
      render json: { error: 'sensor not found' }, status: 404
    end

  end
  
  def in
    @sensor = Api::V1::Sensor.where('slug = ?', params[:slug]).first
    unless @sensor.nil?
      # Save incoming data
      save_sensor_data(@sensor.id, params)

      render json:  { message: 'data was saved' }, status: 200      
    else
      render json:  { error: 'sensor not found' }, status: 404
    end
  end

  private
    
    def save_sensor_data(sensor_id, data)
      # process data
      wmax = 0.00
      wmin = 0.00
      wmin = 0.00

      dir_N = 0
      dir_NNE = 0
      dir_NE = 0
      dir_ENE = 0
      dir_E = 0
      dir_ESE = 0
      dir_SE = 0
      dir_SSE = 0
      dir_S = 0
      dir_SSW = 0
      dir_SW = 0
      dir_WSW = 0
      dir_W = 0
      dir_WNW = 0
      dir_NW = 0
      dir_NNW = 0
      
      w1 = params[:w1].to_f
      w2 = params[:w2].to_f
      w3 = params[:w3].to_f
      w4 = params[:w4].to_f
      w5 = params[:w5].to_f
      wall = params[:wall].to_f
      d1 = params[:d1].to_i
      d2 = params[:d2].to_i
      d3 = params[:d3].to_i
      d4 = params[:d4].to_i
      d5 = params[:d5].to_i
      accum = params[:accum].to_f
      accum = (((4.00 / 1024) * accum) * ((57)/10)).round(2)
      
      alarm = params[:alarm]
      t = params[:t]
      tt = params[:tt]
      pressure = params[:p]
      h = params[:h]
      dp = params[:dp]
      lon = params[:lon]
      lat = params[:lat]
      alt = params[:alt]
      
      tpc = params[:tpc]
      thc = params[:thc]

      
      wmax = (([w1, w2, w3, w4, w5].max / 42.50)*5) ** 0.96
      wmin = (([w1, w2, w3, w4, w5].min / 42.50)*5) ** 0.96
      wmid = (wall/42.50) ** 0.96

      wmax = wmax.round(2)
      wmin = wmin.round(2)
      wmid = wmid.round(2)

      # ---- d1 ----
      if (((d1 >= 992)&&(d1 <= 1024)) || ((d1 > 0)&&(d1 <= 32))) 
          dir_N += 1
      end

      if ((d1 > 32)&&(d1 <= 96)) 
          dir_NNE += 1
      end

      if ((d1 > 96)&&(d1 <= 160))
          dir_NE += 1
      end

      if ((d1 > 160)&&(d1 <= 224))
          dir_ENE += 1
      end

      if ((d1 > 224)&&(d1 <= 288))
          dir_E += 1
      end

      if ((d1 > 288)&&(d1 <= 352))
          dir_ESE += 1
      end

      if ((d1 > 352)&&(d1 <= 416))
          dir_SE += 1
      end

      if ((d1 > 416)&&(d1 <= 480))
          dir_SSE += 1
      end

      if ((d1 > 480)&&(d1 <= 544))
          dir_S += 1
      end

      if ((d1 > 544)&&(d1 <= 608))
          dir_SSW += 1
      end

      if ((d1 > 608)&&(d1 <= 672))
          dir_SW += 1
      end

      if ((d1 > 672)&&(d1 <= 736))
          dir_WSW += 1
      end

      if ((d1 > 736)&&(d1 <= 800))
          dir_W += 1
      end

      if ((d1 > 800)&&(d1 <= 864))
          dir_WNW += 1
      end

      if ((d1 > 864)&&(d1 <= 928))
          dir_NW += 1
      end

      if ((d1 > 828)&&(d1 <= 992))
          dir_NNW += 1
      end

      # ---- d2 ----
      if (((d2 >= 992)&&(d1 <= 1024)) || ((d2 > 0)&&(d1 <= 32)))
          dir_N += 1
      end

      if ((d2 > 32)&&(d2 <= 96)) 
          dir_NNE += 1
      end

      if ((d2 > 96)&&(d2 <= 160))
          dir_NE += 1
      end

      if ((d2 > 160)&&(d2 <= 224))
          dir_ENE += 1
      end

      if ((d2 > 224)&&(d2 <= 288))
          dir_E += 1
      end

      if ((d2 > 288)&&(d2 <= 352))
          dir_ESE += 1
      end

      if ((d2 > 352)&&(d2 <= 416))
          dir_SE += 1
      end

      if ((d2 > 416)&&(d2 <= 480))
          dir_SSE += 1
      end

      if ((d2 > 480)&&(d2 <= 544))
          dir_S += 1
      end

      if ((d2 > 544)&&(d2 <= 608))
          dir_SSW += 1
      end

      if ((d2 > 608)&&(d2 <= 672))
          dir_SW += 1
      end

      if ((d2 > 672)&&(d2 <= 736))
          dir_WSW += 1
      end

      if ((d2 > 736)&&(d2 <= 800))
          dir_W += 1
      end

      if ((d2 > 800)&&(d2 <= 864))
          dir_WNW += 1
      end

      if ((d2 > 864)&&(d2 <= 928))
          dir_NW += 1
      end

      if ((d2 > 828)&&(d2 <= 992))
          dir_NNW += 1
      end

      # ---- d3 ----
      if (((d3 >= 992)&&(d3 <= 1024)) || ((d3 > 0)&&(d3 <= 32)))
          dir_N += 1
      end

      if ((d3 > 32)&&(d3 <= 96)) 
          dir_NNE += 1
      end

      if ((d3 > 96)&&(d3 <= 160))
          dir_NE += 1
      end

      if ((d3 > 160)&&(d3 <= 224))
          dir_ENE += 1
      end

      if ((d3 > 224)&&(d3 <= 288))
          dir_E += 1
      end

      if ((d3 > 288)&&(d3 <= 352))
          dir_ESE += 1
      end

      if ((d3 > 352)&&(d3 <= 416))
          dir_SE += 1
      end

      if ((d3 > 416)&&(d3 <= 480))
          dir_SSE += 1
      end

      if ((d3 > 480)&&(d3 <= 544))
          dir_S += 1
      end

      if ((d3 > 544)&&(d3 <= 608))
          dir_SSW += 1
      end

      if ((d3 > 608)&&(d3 <= 672))
          dir_SW += 1
      end

      if ((d3 > 672)&&(d3 <= 736))
          dir_WSW += 1
      end

      if ((d3 > 736)&&(d3 <= 800))
          dir_W += 1
      end

      if ((d3 > 800)&&(d3 <= 864))
          dir_WNW += 1
      end

      if ((d3 > 864)&&(d3 <= 928))
          dir_NW += 1
      end

      if ((d3 > 828)&&(d3 <= 992))
          dir_NNW += 1
      end

      # ---- d4 ----
      if (((d4 >= 992)&&(d4 <= 1024)) || ((d4 > 0)&&(d4 <= 32)))
          dir_N += 1
      end

      if ((d4 > 32)&&(d4 <= 96)) 
          dir_NNE += 1
      end

      if ((d4 > 96)&&(d4 <= 160))
          dir_NE += 1
      end

      if ((d4 > 160)&&(d4 <= 224))
          dir_ENE += 1
      end

      if ((d4 > 224)&&(d4 <= 288))
          dir_E += 1
      end

      if ((d4 > 288)&&(d4 <= 352))
          dir_ESE += 1
      end

      if ((d4 > 352)&&(d4 <= 416))
          dir_SE += 1
      end

      if ((d4 > 416)&&(d4 <= 480))
          dir_SSE += 1
      end

      if ((d4 > 480)&&(d4 <= 544))
          dir_S += 1
      end

      if ((d4 > 544)&&(d4 <= 608))
          dir_SSW += 1
      end

      if ((d4 > 608)&&(d4 <= 672))
          dir_SW += 1
      end

      if ((d4 > 672)&&(d4 <= 736))
          dir_WSW += 1
      end

      if ((d4 > 736)&&(d4 <= 800))
          dir_W += 1
      end

      if ((d4 > 800)&&(d4 <= 864))
          dir_WNW += 1
      end

      if ((d4 > 864)&&(d4 <= 928))
          dir_NW += 1
      end

      if ((d4 > 828)&&(d4 <= 992))
          dir_NNW += 1
      end

      # ---- d5 ----
      if (((d5 >= 992)&&(d5 <= 1024)) || ((d5 > 0)&&(d5 <= 32)))
          dir_N += 1
      end

      if ((d5 > 32)&&(d5 <= 96)) 
          dir_NNE += 1
      end

      if ((d5 > 96)&&(d5 <= 160))
          dir_NE += 1
      end

      if ((d5 > 160)&&(d5 <= 224))
          dir_ENE += 1
      end

      if ((d5 > 224)&&(d5 <= 288))
          dir_E += 1
      end

      if ((d5 > 288)&&(d5 <= 352))
          dir_ESE += 1
      end

      if ((d5 > 352)&&(d5 <= 416))
          dir_SE += 1
      end

      if ((d5 > 416)&&(d5 <= 480))
          dir_SSE += 1
      end

      if ((d5 > 480)&&(d5 <= 544))
          dir_S += 1
      end

      if ((d5 > 544)&&(d5 <= 608))
          dir_SSW += 1
      end

      if ((d5 > 608)&&(d5 <= 672))
          dir_SW += 1
      end

      if ((d5 > 672)&&(d5 <= 736))
          dir_WSW += 1
      end

      if ((d5 > 736)&&(d5 <= 800))
          dir_W += 1
      end

      if ((d5 > 800)&&(d5 <= 864))
          dir_WNW += 1
      end

      if ((d5 > 864)&&(d5 <= 928))
          dir_NW += 1
      end

      if ((d5 > 828)&&(d5 <= 992))
          dir_NNW += 1
      end
      



      # Direction search
      dir = ''

      if (dir_N > (dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW) / 15)
          dir = 'N';
      end
      if (dir_NNE > (dir_N+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'NNE';
      end
      if (dir_NE > (dir_N+dir_NNE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'NE';
      end
      if (dir_ENE > (dir_N+dir_NNE+dir_NE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'ENE';
      end
      if (dir_E > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'E';
      end
      if (dir_ESE > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'ESE';
      end
      if (dir_SE > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'SE';
      end
      if (dir_S > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'S';
      end
      if (dir_SSW > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'SSW';
      end

      if (dir_SW > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_WSW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'SW';
      end

      if (dir_WSW > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_W+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'WSW';
      end

      if (dir_W > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_WNW+dir_NW+dir_NNW)/15)
          dir = 'W';
      end

      if (dir_WNW > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_NW+dir_NNW)/15)
          dir = 'WNW';
      end

      if (dir_NW > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NNW)/15)
          dir = 'NW';
      end

      if (dir_NNW > (dir_N+dir_NNE+dir_NE+dir_ENE+dir_E+dir_ESE+dir_SE+dir_SSE+dir_S+dir_SSW+dir_SW+dir_WSW+dir_W+dir_WNW+dir_NW)/15)
          dir = 'NNW';
      end


      # ----------------

      w1 = ((w1/42.50)*5) ** 0.96
      w2 = ((w2/42.50)*5) ** 0.96
      w3 = ((w3/42.50)*5) ** 0.96
      w4 = ((w4/42.50)*5) ** 0.96
      w5 = ((w5/42.50)*5) ** 0.96


      # added proc
      proc = 0;
      
      proc = proc + 20 if ((wmax / 100*95) < w1)
      proc = proc + 20 if ((wmax / 100*95) < w2)
      proc = proc + 20 if ((wmax / 100*95) < w3)
      proc = proc + 20 if ((wmax / 100*95) < w4)
      proc = proc + 20 if ((wmax / 100*95) < w5)


      # if (($a + $b) == 0) {$c = 0;}
      if (wmax == 0) 
         wmid = 0 
         wmin = 0 
         proc = 0 
         dir = 'calm'
      end

      sensor_data = Api::V1::SensorData.new
      sensor_data.sensor_id = sensor_id
      sensor_data.wind      = wmax
      sensor_data.mid       = wmid
      sensor_data.lwind     = wmin
      sensor_data.dir       = dir
      sensor_data.temp1     = tpc
      sensor_data.temp2     = thc
      sensor_data.h         = h
      sensor_data.p         = pressure
      sensor_data.dew_point = dp
      sensor_data.alarm     = alarm 
      sensor_data.u_out     = accum

      sensor_data.save
      
    end
end
