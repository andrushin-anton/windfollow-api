class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :rating, :image, :about, :birth_date, :gender, :phone, :web_site, :country, :city, :created_at, :sports

  def sports
  	object.sports.map do |sport|
      Api::V1::SportSerializer.new(sport, scope: scope, root: false, event: object)
    end
  end
end
