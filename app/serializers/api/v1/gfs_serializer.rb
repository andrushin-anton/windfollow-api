class Api::V1::GfsSerializer < ActiveModel::Serializer
  attributes :rt, :vt, :lat, :lon, :wind_dir, :wind_dir_deg, :wind_speed, :temp, :GUST_0, :CPRAT_0, :UGRD_1, :VGRD_1, :TCDC_925, :TCDC_700, :TCDC_500, :APCP_0

  def temp
    unless object.TMP_0.nil?
      # T(°C) = T(K) - 273.15
      return (object.TMP_0 - 273.15).round(1)  
    end
  end

  def wind_speed
    unless object.UGRD_1.nil? && object.VGRD_1.nil?
      return (Math::sqrt((object.UGRD_1 ** 2) + (object.VGRD_1 ** 2))).round(1)    
    end
  end

  def wind_dir_deg
    unless object.UGRD_1.nil? && object.VGRD_1.nil?
      if(object.VGRD_1 > 0)
        return (((180 / Math::PI) * Math::atan(object.UGRD_1/object.VGRD_1) + 180)).round(2)
      elsif(object.UGRD_1 < 0 && object.VGRD_1 < 0)
        return (((180 / Math::PI) * Math::atan(object.UGRD_1/object.VGRD_1) + 0)).round(2)
      elsif(object.UGRD_1 > 0 && object.VGRD_1 < 0)
        return (((180 / Math::PI) * Math::atan(object.UGRD_1/object.VGRD_1) + 360)).round(2)
      else
        return 147 #SSE
      end
    end  
  end

  def wind_dir
    unless object.UGRD_1.nil? && object.VGRD_1.nil?
      if(object.VGRD_1 > 0)
        dir_deg = (((180 / Math::PI) * Math::atan(object.UGRD_1/object.VGRD_1) + 180)).round(2)
      elsif(object.UGRD_1 < 0 && object.VGRD_1 < 0)
        dir_deg = (((180 / Math::PI) * Math::atan(object.UGRD_1/object.VGRD_1) + 0)).round(2)
      elsif(object.UGRD_1 > 0 && object.VGRD_1 < 0)
        dir_deg = (((180 / Math::PI) * Math::atan(object.UGRD_1/object.VGRD_1) + 360)).round(2)
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
      if dir_deg > 326.25 && dir_deg <= 326.75
        return 'NNW'
      end
    end     
  end
end