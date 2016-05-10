class Api::V1::Message < ActiveRecord::Base
	validates :sender_id, presence: true
	validates :recepient_id, presence: true
	validates :content, presence: true
end
