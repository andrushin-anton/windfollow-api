class Api::V1::FavoriteSpotSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :spot, :closed
  
  def spot
  	Api::V1::SpotSerializer.new(Api::V1::Spot.where('id = ?', object.spot_id).first, { root: false })
  end
end
