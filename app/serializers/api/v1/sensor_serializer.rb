class Api::V1::SensorSerializer < ActiveModel::Serializer
  attributes :name, :slug, :geo_lat, :geo_lon, :data

  def data
    Api::V1::SensorData.where('sensor_id = ?', object.id).order('created_at DESC').first
  end
end
