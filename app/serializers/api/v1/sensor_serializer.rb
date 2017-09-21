class Api::V1::SensorSerializer < ActiveModel::Serializer
  attributes :name, :slug, :geo_lat, :geo_lon, :data, :mid

  def data
    result = []
    one_hour_ago = 1.hour.ago
    data = Api::V1::SensorData.where('sensor_id = ? AND created_at >= ?', object.id, (one_hour_ago).to_s(:db)).order('created_at DESC').all

    unless data.nil?
      prev_data = data[0]

      (one_hour_ago.to_datetime.to_i .. Time.now.to_datetime.to_i).step(1.minute) do |date|
        found_data = self.find_minute_in_data(date, data)
        unless found_data.nil?
          result << found_data
        else
          result << prev_data
        end
      end
    end
    result
  end

  def find_minute_in_data(needle, data)
    data.each do |date|
      if date.strftime('%H:%M') == needle.strftime('%H:%M')
        return date
      end
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
