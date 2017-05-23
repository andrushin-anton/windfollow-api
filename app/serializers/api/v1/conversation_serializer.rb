class Api::V1::ConversationSerializer < ActiveModel::Serializer
  attributes :id, :sender, :recipient, :message_preview, :created_at, :updated_at

  def sender
  	Api::V1::UserFollowerSerializer.new(object.sender, { root: false })
  end

  def recipient
  	Api::V1::UserFollowerSerializer.new(object.recipient, { root: false })
  end

  def message_preview
    Api::V1::MessageSerializer.new(object.messages.last, { root: false })
  end

end
