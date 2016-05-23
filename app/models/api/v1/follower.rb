class Api::V1::Follower < ActiveRecord::Base
	validates :user_id, presence: true, :numericality => true

	belongs_to :user
end
