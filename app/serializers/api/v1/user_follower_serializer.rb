class Api::V1::UserFollowerSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :rating, :country, :city, :created_at, :avatar, :online

  def avatar
  	object.avatar.url.sub! 's3.amazonaws.com/windfollow', 'windfollow.s3.amazonaws.com'
  end

  def online
    if Api::V1::UserActivity.where('user_id = ? and updated_at >= ?', object.id, DateTime.now - 30.minutes).exists?
      return 'true'
    else
      return 'false'
    end
  end

end