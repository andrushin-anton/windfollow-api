class Api::V1::MessageSerializer < ActiveModel::Serializer
  attributes :id, :sender, :recepient, :content, :viewed, :created_at

  def sender
  	Api::V1::UserFollowerSerializer.new(object.sender, { root: false })
  end

  def recepient
  	Api::V1::UserFollowerSerializer.new(object.recepient, { root: false })
  end

end
