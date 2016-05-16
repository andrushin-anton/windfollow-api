class Api::V1::Message < ActiveRecord::Base
	validates :sender_id, presence: true
	validates :recepient_id, presence: true
	validates :content, presence: true

	scope :filter_by_user, -> (user_id) { where('sender_id =?', user_id) }
	scope :filter_by_recepient, -> (user_id) { where('recepient_id =?', user_id) }
	scope :recent, -> () { order('created_at DESC') }
end
