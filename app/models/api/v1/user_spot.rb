class Api::V1::UserSpot < ActiveRecord::Base
    belongs_to :user
	belongs_to :spot
end
