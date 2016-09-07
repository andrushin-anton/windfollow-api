class Api::V1::AlertSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :distance, :time_alert
end
