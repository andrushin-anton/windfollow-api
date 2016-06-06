class Api::V1::SpotEstimate < ActiveRecord::Base
	validates :spot_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :best_month, presence: true
  validates :wave, presence: true
  validates :level, presence: true
  validates :user_id, presence: true
  validates :sport, presence: true
end
