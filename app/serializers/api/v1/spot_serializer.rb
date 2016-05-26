class Api::V1::SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :geo_lat, :geo_lon, :rating, :best_month, :wave, :level, :user_id, :country, :city, :sport
end
