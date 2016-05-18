class Api::V1::Sport < ActiveRecord::Base
	validates :name, presence: true

	has_many :sport_users
	has_many :users, through: :sport_users
end
