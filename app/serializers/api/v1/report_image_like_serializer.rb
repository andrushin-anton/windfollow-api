class Api::V1::ReportImageLikeSerializer < ActiveModel::Serializer
  attributes :id, :user, :report_image_id

  def user
  	Api::V1::UserFollowerSerializer.new(object.user, { root: false })
  end
end
