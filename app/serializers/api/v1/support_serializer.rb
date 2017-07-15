class Api::V1::SupportSerializer < ActiveModel::Serializer
  attributes :id, :message, :details
end
