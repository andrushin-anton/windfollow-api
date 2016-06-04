class Api::V1::ReportImageCommentSerializer < ActiveModel::Serializer
  attributes :id, :report_image_id, :user, :content

  def user
  	Api::V1::UserFollowerSerializer.new(object.user, { root: false })
  end
end
