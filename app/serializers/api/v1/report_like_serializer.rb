class Api::V1::ReportLikeSerializer < ActiveModel::Serializer
  attributes :id, :user, :report_id

  def user
  	Api::V1::UserFollowerSerializer.new(object.user, { root: false })
  end
end
