class Api::V1::SpotEstimateSerializer < ActiveModel::Serializer
  attributes :id, :spot_id, :user_id, :rating, :best_month, :wave, :level, :sport
end
