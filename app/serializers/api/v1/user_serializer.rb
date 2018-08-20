class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :rating, :about, :birth_date, :gender, :phone, :web_site, :country, :city, :created_at, :avatar, :sports, :followers, :followings, :wind, :temp, :alerts, :favorite_spots, :reports, :online

  def sports
  	object.sports.map do |sport|
      Api::V1::SportSerializer.new(sport, scope: scope, root: false, event: object)
    end
  end

  def avatar
  	object.formated_avatar
  end

  def followers
  	object.followings.count(:all)
  end

  def followings
  	object.followers.count(:all)
  end

  def reports
    object.reports.count(:all)
  end

  def alerts
    Api::V1::Alert.where('user_id = ?', object.id).first
  end

  def favorite_spots
    Api::V1::FavoriteSpot.where('user_id = ?', object.id).count(:all)
  end

  def online
    if Api::V1::UserActivity.where('user_id = ? and updated_at >= ?', object.id, DateTime.now - 30.minutes).exists?
      return 'true'
    else
      return 'false'
    end
  end
end
