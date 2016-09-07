class Api::V1::DeviceSerializer < ActiveModel::Serializer
  attributes :id, :name, :token, :user_id
end
