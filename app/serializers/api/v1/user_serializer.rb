class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :rating, :about, :birth_date, :gender, :phone, :web_site, :country, :city, :created_at, :avatar, :sports

  def sports
  	object.sports.map do |sport|
      Api::V1::SportSerializer.new(sport, scope: scope, root: false, event: object)
    end
  end

  def avatar
  	object.avatar.url.sub! 's3.amazonaws.com/windfollow', 'windfollow.s3.amazonaws.com'
  end
end
