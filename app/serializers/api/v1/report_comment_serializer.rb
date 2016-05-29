class Api::V1::ReportCommentSerializer < ActiveModel::Serializer
  attributes :id, :report_id, :user_id, :content
end
