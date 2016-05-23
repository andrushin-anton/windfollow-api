class Api::V1::UserFollowerSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :rating, :country, :city, :created_at, :avatar

  def avatar
  	object.avatar.url.sub! 's3.amazonaws.com/windfollow', 'windfollow.s3.amazonaws.com'
  end
end