class Api::V1::ReportSerializer < ActiveModel::Serializer
  attributes :id, :spot_id, :content, :user_id, :place, :wind, :direction, :comments, :likes

  def comments
  	object.report_comments.count(:all)
  end

  def likes
  	object.report_likes.count(:all)
  end
end
