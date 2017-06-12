class Api::V1::Gfs < ActiveRecord::Base
	attr_accessor :current_temp, :current_wind


  def self.find_data_by_coordinates(geo_lat, geo_lon, temp, wind)
    # we need to get the last insert time
    rec = Api::V1::Gfs.order('rt desc').first

    unless rec.nil?
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
      data = Api::V1::Gfs.where('lat = ? AND lon = ? AND rt = ? AND vt IN(?)', Api::V1::Gfs.interpolate_2_5(params[:lat]), Api::V1::Gfs.interpolate_2_5(params[:lon]), rec.rt, hours_list).all

      # For precipation:
      # current value needs to be substucted from prev
      # in every 6 hours range 
      prev_apcp = 0
      ignore_hours = ['00', '06', '12', '18']

      unless data.nil?
        data.each do |hour|
          # set users prefered settings
          hour.current_temp = temp
          hour.current_wind = wind          

          # calculate precipation
          unless hour.APCP_0.nil?
            temp_apcp_value = hour.APCP_0
            # if this hour is not begining of a new circle
            unless ignore_hours.include? hour.vt.strftime("%H")
              if prev_apcp > hour.APCP_0
                hour.APCP_0 = 0
              else
                hour.APCP_0 = (hour.APCP_0 - prev_apcp).round(1)
              end
            end
            # set previous apcp value
            prev_apcp = temp_apcp_value
          end
        end
        return data
      else
        return nil
      end      
    else
      return nil
    end

  end

  def self.interpolate_2_5(point)
    base_floor = point.to_f.floor
    xs = [base_floor, base_floor + 0.25, base_floor + 0.50, base_floor + 0.75, base_floor + 1]
    xs.min_by(1) { |x| (x.to_f - point.to_f).abs }
  end
end
