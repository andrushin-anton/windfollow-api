class Api::V1::Message < ActiveRecord::Base
	validates :sender_id, presence: true
	validates :recepient_id, presence: true
	validates :content, presence: true

	belongs_to :sender, class_name: "User" 
	belongs_to :recepient, class_name: "User" 

	scope :filter_by_user, -> (user_id) { where('sender_id =?', user_id) }
	scope :filter_by_recepient, -> (user_id) { where('recepient_id =?', user_id) }
	scope :recent, -> () { order('created_at DESC') }

	def self.make_viewed(current_user_id, sender_id)
		Api::V1::Message.where('sender_id = ? AND recepient_id = ? AND viewed = 0', sender_id, current_user_id).update_all(viewed: 1)
	end
end
