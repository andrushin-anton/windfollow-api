class Api::V1::MessageSerializer < ActiveModel::Serializer
  attributes :body, :sender, :created_at, :read, :updated_at

  def sender
  	Api::V1::UserFollowerSerializer.new(object.user, { root: false })
  end

end
