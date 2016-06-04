class Api::V1::ReportImageLike < ActiveRecord::Base
	validates :report_image_id, presence: true, numericality: { greater_than_or_equal_to: 1 }

	belongs_to :user
end
