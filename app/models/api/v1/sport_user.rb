class Api::V1::SportUser < ActiveRecord::Base
	validates :sport_id, numericality: { only_integer: true }, presence: true

	belongs_to :user
	belongs_to :sport
end
