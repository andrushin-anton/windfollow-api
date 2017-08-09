class Api::V1::SensorSerializer < ActiveModel::Serializer
  attributes :name, :slug, :geo_lat, :geo_lon, :data

  def data
    Api::V1::SensorData.where('sensor_id = ? AND created_at >= NOW() - INTERVAL 1 HOUR', object.id).order('created_at DESC').all
  end
end
