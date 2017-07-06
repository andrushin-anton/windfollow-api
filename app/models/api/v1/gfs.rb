require 'date'

class Api::V1::Gfs < ActiveRecord::Base
	attr_accessor :current_temp, :current_wind, :precipitation


  def self.find_data_by_coordinates(geo_lat, geo_lon, temp, wind, hours_limit = 239)
    # we need to get the last insert time
    rec = Api::V1::Gfs.order('rt desc').first

    unless rec.nil?
      # generate each hour list forecast for next 10 days
      hours_list = []
      date = rec.rt
      next_hour = DateTime.new(date.year, date.month, date.day, date.hour)
      hours_list << next_hour

      for i in 1..hours_limit
        date = date + 60*60 # +1 hour
        next_hour = DateTime.new(date.year, date.month, date.day, date.hour)
        hours_list << next_hour
      end


      #SELECT * FROM windfollow.gfs_2_5 where lat = -90 and lon = 0.25 and rt = '2016-08-06 12:00:00' and vt in('2016-08-06 13:00:00', '2016-08-06 14:00:00');
      @data = Api::V1::Gfs.where('lat = ? AND lon = ? AND rt = ? AND vt IN(?)', Api::V1::Gfs.interpolate_2_5(geo_lat), Api::V1::Gfs.interpolate_2_5(geo_lon), rec.rt, hours_list).all

      # For precipation:
      # current value needs to be substucted from prev
      # in every 6 hours range 
      prev_apcp = 0
      ignore_hours = ['00', '06', '12', '18']

      unless @data.nil?
        @data.each do |hour|
          # set users prefered settings
          hour.current_temp = temp
          hour.current_wind = wind 
          hour.precipitation = hour.APCP_0         

          # calculate precipation
          unless hour.precipitation.nil?
            temp_apcp_value = hour.precipitation
            # if this hour is not begining of a new circle
            unless ignore_hours.include? hour.vt.strftime("%H")
              if prev_apcp > hour.precipitation
                hour.precipitation = 0
              else
                hour.precipitation = (hour.precipitation - prev_apcp).round(1)
              end
            end
            # set previous apcp value
            prev_apcp = temp_apcp_value
          end
        end
        return @data
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

  def temp
    unless self.TMP_0.nil?
      if self.current_temp == 'c'
        # T(°C) = T(K) - 273.15
        return (self.TMP_0 - 273.15).round(1)
      else
        # T(°F) = T(K) × 9/5 - 459.67
        return ((self.TMP_0 * 1.8) - 459.67).round(1)
      end
    end
  end

  def wind_speed
    unless self.UGRD_1.nil? && self.VGRD_1.nil?
      # calculate wind speed in m/s
      wind_speed_in_metresec = (Math::sqrt((self.UGRD_1 ** 2) + (self.VGRD_1 ** 2))).round(1)

      if self.current_wind == 'm/s'
        return wind_speed_in_metresec
      elsif self.current_wind == 'mph'
        # mph = m/s ÷ 0.44704
        return (wind_speed_in_metresec / 0.44704).round(1)
      elsif self.current_wind == 'km/h'
        # km/h = m/s x 3.6
        return (wind_speed_in_metresec * 3.6).round(1)
      elsif self.current_wind == 'bft'
        # Beaufort Wind Scale
        # 0 B = < 0.3 m/s
        if wind_speed_in_metresec < 0.3
          return 0
        # 1 B = >= 0.3 && <= 1.5 m/s   
        elsif wind_speed_in_metresec >= 0.3 && wind_speed_in_metresec <= 1.5
          return 1
        # 2 B = >= 1.6 && <= 3.3 m/s 
        elsif wind_speed_in_metresec >= 1.6 && wind_speed_in_metresec <= 3.3
          return 2
        # 3 B = >= 3.4 && <= 5.5 m/s
        elsif wind_speed_in_metresec >= 3.4 && wind_speed_in_metresec <= 5.5
          return 3
        # 4 B = >= 5.6 && <= 7.9 m/s
        elsif wind_speed_in_metresec >= 5.6 && wind_speed_in_metresec <= 7.9
          return 4
        # 5 B = >= 8 && <= 10.7 m/s
        elsif wind_speed_in_metresec >= 8 && wind_speed_in_metresec <= 10.7
          return 5
        # 6 B = >= 10.8 && <= 13.8 m/s
        elsif wind_speed_in_metresec >= 10.8 && wind_speed_in_metresec <= 13.8
          return 6
        # 7 B = >= 13.9 && <= 17.1 m/s
        elsif wind_speed_in_metresec >= 13.9 && wind_speed_in_metresec <= 17.1
          return 7
        # 8 B = >= 17.2 && 20.7 m/s
        elsif wind_speed_in_metresec >= 17.2 && wind_speed_in_metresec <= 20.7
          return 8
        # 9 B = >= 20.8 && <= 24.4 m/s
        elsif wind_speed_in_metresec >= 20.8 && wind_speed_in_metresec <= 24.4
          return 9
        # 10 B = >= 24.5 && <= 28.4 m/s
        elsif wind_speed_in_metresec >= 24.5 && wind_speed_in_metresec <= 28.4
          return 10
        # 11 B = >= 28.5 && <= 32.6 m/s
        elsif wind_speed_in_metresec >= 28.5 && wind_speed_in_metresec <= 32.6
          return 11
        else
        # 12 B >= 32.7 m/s
          return 12   
        end       

      elsif self.current_wind == 'knots'
        # kn = m/s * 1.94384449
        return (wind_speed_in_metresec * 1.94384449).round(1)
      end
    end
  end

  def wind_dir_deg
    unless self.UGRD_1.nil? && self.VGRD_1.nil?
      if(self.VGRD_1 > 0)
        return (((180 / Math::PI) * Math::atan(self.UGRD_1/self.VGRD_1) + 180)).round(2)
      elsif(self.UGRD_1 < 0 && self.VGRD_1 < 0)
        return (((180 / Math::PI) * Math::atan(self.UGRD_1/self.VGRD_1) + 0)).round(2)
      elsif(self.UGRD_1 > 0 && self.VGRD_1 < 0)
        return (((180 / Math::PI) * Math::atan(self.UGRD_1/self.VGRD_1) + 360)).round(2)
      else
        return 147 #SSE
      end
    end  
  end

  def wind_dir
    unless self.UGRD_1.nil? && self.VGRD_1.nil?
      if(self.VGRD_1 > 0)
        dir_deg = (((180 / Math::PI) * Math::atan(self.UGRD_1/self.VGRD_1) + 180)).round(2)
      elsif(self.UGRD_1 < 0 && self.VGRD_1 < 0)
        dir_deg = (((180 / Math::PI) * Math::atan(self.UGRD_1/self.VGRD_1) + 0)).round(2)
      elsif(self.UGRD_1 > 0 && self.VGRD_1 < 0)
        dir_deg = (((180 / Math::PI) * Math::atan(self.UGRD_1/self.VGRD_1) + 360)).round(2)
      else
        dir_deg = 147 #SSE
      end

      # Degree Direction to Cardinal Direction

      # N  348.75 - 11.25
      if dir_deg > 348.75 || dir_deg <= 11.25
        return 'N'
      end

      # NNE  11.25 - 33.75
      if dir_deg > 11.25 && dir_deg <= 33.75
        return 'NNE'
      end

      # NE  33.75 - 56.25
      if dir_deg > 33.75 && dir_deg <= 56.25
        return 'NE'
      end

      # ENE  56.25 - 78.75
      if dir_deg > 56.25 && dir_deg <= 78.75
        return 'ENE'
      end

      # E  78.75 - 101.25
      if dir_deg > 78.75 && dir_deg <= 101.25
        return 'E'
      end

      # ESE  101.25 - 123.75
      if dir_deg > 101.25 && dir_deg <= 123.75
        return 'ESE'
      end

      # SE  123.75 - 146.25
      if dir_deg > 123.75 && dir_deg <= 146.25
        return 'SE'
      end

      # SSE  146.25 - 168.75
      if dir_deg > 146.25 && dir_deg <= 168.75
        return 'SSE'
      end

      # S  168.75 - 191.25
      if dir_deg > 168.75 && dir_deg <= 191.25
        return 'S'
      end

      # SSW  191.25 - 213.75
      if dir_deg > 191.25 && dir_deg <= 213.75
        return 'SSW'
      end

      # SW  213.75 - 236.25
      if dir_deg > 213.75 && dir_deg <= 236.25
        return 'SW'
      end

      # WSW  236.25 - 258.75
      if dir_deg > 236.25 && dir_deg <= 258.75
        return 'WSW'
      end

      # W  258.75 - 281.25
      if dir_deg > 258.75 && dir_deg <= 281.25
        return 'W'
      end

      # WNW  281.25 - 303.75
      if dir_deg > 281.25 && dir_deg <= 303.75
        return 'WNW'
      end

      # NW  303.75 - 326.25
      if dir_deg > 303.75 && dir_deg <= 326.25
        return 'NW'
      end

      # NNW  326.25 - 348.75
      if dir_deg > 326.25 && dir_deg <= 348.75
        return 'NNW'
      end
    end     
  end
  
end
