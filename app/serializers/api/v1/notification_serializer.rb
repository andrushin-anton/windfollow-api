class Api::V1::NotificationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_type, :content, :event_object_id
end
