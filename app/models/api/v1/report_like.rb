class Api::V1::ReportLike < ActiveRecord::Base
	validates :report_id, presence: true, numericality: { greater_than_or_equal_to: 1 }

	belongs_to :user 

	after_create :notify

	def notify
		# get report
		report = Api::V1::Report.find(self.report_id)
		# find user 
		user = Api::V1::User.find(self.user_id)
		# create new notification
		notification = Api::V1::Notification.new
		notification.user_id = report.user_id
		notification.event_type = Api::V1::Notification::TYPE_REPORT_LIKE
		notification.content = {:event_user_id => user.id, :event_user_name => user.first_name + ' ' + user.last_name, :event_user_avatar => user.formated_avatar}.to_json
		notification.event_object_id = self.report_id
		notification.save
	end
end
