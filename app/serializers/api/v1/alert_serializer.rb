class Api::V1::AlertSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :spot, :direction, :time_alert, :speed_from, :speed_to

  def spot
  	Api::V1::SpotSerializer.new(object.spot, { root: false })
  end
end
