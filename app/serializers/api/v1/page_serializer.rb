class Api::V1::PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end
