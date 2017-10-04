class Api::V1::SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :geo_lat, :geo_lon, :rating, :best_month, :wave, :level, :user_id, :country, :city, :sport, :followers, :created_at, :updated_at, :meteo

  def rating
  	rating = object.rating.to_f
  	estimates = Api::V1::SpotEstimate.where('spot_id = ?', object.id).all

  	if estimates
  		estimates.each do |item|
  			rating = rating + item.rating
  		end
  		rating = (rating / (estimates.length + 1)).to_f
  	end
  	return rating
  end

  def best_month
  	count = 1
  	months = {'1' => 0.0 ,'2' => 0.0 ,'3' => 0.0 ,'4' => 0.0 ,'5' => 0.0 ,'6' => 0.0 ,'7' => 0.0 ,'8' => 0.0 ,'9' => 0.0 ,'10' => 0.0 ,'11' => 0.0 ,'12' => 0.0}
  	estimates = Api::V1::SpotEstimate.where('spot_id = ?', object.id).all

    unless object.best_month.nil?
      object.best_month.split(',').map { |k| months[k] = months[k] + 1 }
    end

  	if estimates
  		estimates.each do |item|
  			item.best_month.split(',').map { |k| months[k] = months[k] + 1 }
  		end
  		count = estimates.length + 1
  	end

  	months.each do |(k,v)|
  		months[k] = v / count 
  	end

  	return months
  end

	def followers
		Api::V1::UserSpot.where('spot_id = ?', object.id).count(:all)
	end

	def meteo
		geo_lat = (object.geo_lat.to_f * 100).floor / 100.0
		geo_lon = (object.geo_lon.to_f * 100).floor / 100.0
		query_params = {}
		query_params[:geo_lat] = "%#{geo_lat.to_s}%"
		query_params[:geo_lon] = "%#{geo_lon.to_s}%"
		sensor = Api::V1::Sensor.where('geo_lat LIKE :geo_lat AND geo_lon LIKE :geo_lon', query_params).first
		unless sensor.nil?
			return 'true'
		else
			return 'false'
		end
	end

end
