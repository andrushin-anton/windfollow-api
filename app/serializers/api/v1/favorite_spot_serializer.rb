class Api::V1::FavoriteSpotSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :spot

  def spot
  	Api::V1::Spot.where('id = ?', object.spot_id).first  	
  end
end
