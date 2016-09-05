class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :rating, :about, :birth_date, :gender, :phone, :web_site, :country, :city, :created_at, :avatar, :sports, :followers, :followings, :wind, :temp

  def sports
  	object.sports.map do |sport|
      Api::V1::SportSerializer.new(sport, scope: scope, root: false, event: object)
    end
  end

  def avatar
  	object.formated_avatar
  end

  def followers
  	object.followers.count(:all)
  end

  def followings
  	object.followings.count(:all)
  end
end
