class Api::V1::MessageSerializer < ActiveModel::Serializer
  attributes :body, :sender, :conversation_id, :created_at, :read, :updated_at

  def sender
  	Api::V1::UserFollowerSerializer.new(object.user, { root: false })
  end

  def conversation_id
    object.conversation.id
  end

end
