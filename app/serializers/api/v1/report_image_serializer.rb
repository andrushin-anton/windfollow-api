class Api::V1::ReportImageSerializer < ActiveModel::Serializer
  attributes :id, :report_id, :user_id, :image

  def image
  	object.image.url.sub! 's3.amazonaws.com/windfollow', 'windfollow.s3.amazonaws.com'
  end
end
