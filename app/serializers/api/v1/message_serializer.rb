class Api::V1::MessageSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :recepient_id, :content, :created_at
end
