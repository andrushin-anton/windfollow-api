class Api::V1::SensorSerializer < ActiveModel::Serializer
  attributes :name, :slug, :geo_lat, :geo_lon, :data, :mid

  def data
    result = []
    one_hour_ago = Time.current - 1.hour
    data = Api::V1::SensorData.where('sensor_id = ? AND created_at >= ?', object.id, (one_hour_ago).to_s(:db)).order('created_at DESC').all

    unless data.nil?
      prev_data = data[0]

      (one_hour_ago.to_datetime.to_i .. Time.current.to_datetime.to_i).step(1.minute) do |date|
        found_data = self.find_minute_in_data(date, data, prev_data)
        unless found_data.nil?
          prev_data = found_data
          result << found_data
        end
      end
    end
    result
  end

  def find_minute_in_data(needle, data, prev_minute)
    data.each do |date|
      if date.created_at.strftime('%H:%M') == Time.zone.at(needle).in_time_zone.strftime('%H:%M')
        return date
      end
    end

    unless prev_minute.nil?
      new_minute = Api::V1::SensorData.new
      new_minute.created_at = Time.zone.at(needle).to_datetime
      new_minute.updated_at = Time.zone.at(needle).to_datetime
      new_minute.id = prev_minute.id
      new_minute.sensor_id = prev_minute.sensor_id
      new_minute.wind = prev_minute.wind
      new_minute.mid = prev_minute.mid
      new_minute.lwind = prev_minute.lwind
      new_minute.dir = prev_minute.dir
      new_minute.temp1 = prev_minute.temp1
      new_minute.temp2 = prev_minute.temp2
      new_minute.h = prev_minute.h
      new_minute.p = prev_minute.p
      new_minute.dew_point = prev_minute.dew_point
      new_minute.alarm = prev_minute.alarm
      new_minute.u_out = prev_minute.u_out

      new_minute
    end

  end

  def mid
    result_array = []
    result = {}
    seven_hours_back = (Time.now - 7.hours).to_s(:db)
    six_hours_back = (Time.now - 6.hours).to_s(:db)
    five_hours_back = (Time.now - 5.hours).to_s(:db)
    four_hours_back = (Time.now - 4.hours).to_s(:db)
    three_hours_back = (Time.now - 3.hours).to_s(:db)
    two_hours_back = (Time.now - 2.hours).to_s(:db)
    one_hour_back = (Time.now - 1.hour).to_s(:db)
    now = Time.now.to_s(:db)
    result[six_hours_back] = Api::V1::SensorData.where('sensor_id = ? AND (created_at >= ? AND created_at <= ?)', object.id, seven_hours_back, six_hours_back).average(:mid)
    result[five_hours_back] = Api::V1::SensorData.where('sensor_id = ? AND (created_at >= ? AND created_at <= ?)', object.id, six_hours_back, five_hours_back).average(:mid)
    result[four_hours_back] = Api::V1::SensorData.where('sensor_id = ? AND (created_at >= ? AND created_at <= ?)', object.id, five_hours_back, four_hours_back).average(:mid)
    result[three_hours_back] = Api::V1::SensorData.where('sensor_id = ? AND (created_at >= ? AND created_at <= ?)', object.id, four_hours_back, three_hours_back).average(:mid)
    result[two_hours_back] = Api::V1::SensorData.where('sensor_id = ? AND (created_at >= ? AND created_at <= ?)', object.id, three_hours_back, two_hours_back).average(:mid)
    result[one_hour_back] = Api::V1::SensorData.where('sensor_id = ? AND (created_at >= ? AND created_at <= ?)', object.id, two_hours_back, one_hour_back).average(:mid)
    result[now] = Api::V1::SensorData.where('sensor_id = ? AND (created_at >= ? AND created_at <= ?)', object.id, one_hour_back, now).average(:mid)
    
    result_array << result
  end
end
