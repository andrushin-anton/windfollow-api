class Api::V1::Alert < ActiveRecord::Base
	validates :distance, presence: true
	validates :time_alert, presence: true

	belongs_to :user
end
