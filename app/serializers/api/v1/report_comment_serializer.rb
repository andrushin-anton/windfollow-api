class Api::V1::ReportCommentSerializer < ActiveModel::Serializer
  attributes :id, :report_id, :user_id, :content, :created_at, :updated_at
end
