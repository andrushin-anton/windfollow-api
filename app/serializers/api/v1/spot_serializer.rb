class Api::V1::SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :geo_lat, :geo_lon, :rating, :best_month, :wave, :level, :user_id, :country, :city, :sport

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
end
