class Api::V1::ReportImageCommentSerializer < ActiveModel::Serializer
  attributes :id, :report_image_id, :user, :content, :created_at, :updated_at

  def user
  	Api::V1::UserFollowerSerializer.new(object.user, { root: false })
  end
end
