class Api::V1::FollowerSerializer < ActiveModel::Serializer
  attributes :user

  def user
  	Api::V1::UserFollowerSerializer.new(object.user, { root: false })
  end
end
