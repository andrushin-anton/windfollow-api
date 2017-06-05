class Api::V1::Alert < ActiveRecord::Base
	validates :direction, presence: true
	validates :spot_id, presence: true
	validates :speed_from, presence: true
	validates :speed_to, presence: true

	belongs_to :user
	belongs_to :spot

	before_save :default_values

	def default_values
		self.time_alert ||= '0-24'
	end
end
