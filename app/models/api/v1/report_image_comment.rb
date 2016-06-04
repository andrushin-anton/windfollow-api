class Api::V1::ReportImageComment < ActiveRecord::Base
	validates :report_image_id, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :content, presence: true

	belongs_to :user

	scope :recent, -> () { order('created_at DESC') }
end
