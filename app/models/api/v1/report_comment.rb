class Api::V1::ReportComment < ActiveRecord::Base
	validates :report_id, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :content, presence: true

	belongs_to :user

	scope :recent, -> () { order('created_at DESC') }

	after_create :notify
	attr_accessor :notify_people

	after_initialize :default_values

  def default_values
    self.notify_people = true
  end

	def get_image_url
		image = Api::V1::ReportImage.where('report_id = ?', self.report_id).first
		unless image.nil?
			return image.image.url.sub! 's3.amazonaws.com/windfollow', 'windfollow.s3.amazonaws.com'	
		end
	end

	def notify
		if self.notify_people == true
			# get report
			report = Api::V1::Report.find(self.report_id)
			# find user 
			user = Api::V1::User.find(self.user_id)
			# if it is not the report author
			if self.user_id != report.user_id
				# create new notification
				notification = Api::V1::Notification.new
				notification.user_id = report.user_id
				notification.event_type = Api::V1::Notification::TYPE_REPORT_COMMENT
				notification.content = { :event_user_id => user.id, :event_user_name => user.first_name + ' ' + user.last_name, :event_user_avatar => user.formated_avatar, :event_content => self.content, :event_image_url => self.get_image_url, :report => report }.to_json
				notification.event_object_id = self.report_id
				notification.save
			end
		end
	end
end
