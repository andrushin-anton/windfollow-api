class Api::V1::Following < ActiveRecord::Base
	self.table_name = "api_v1_followers"

	belongs_to :user, :foreign_key => 'follower_id'
end
