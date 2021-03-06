class Api::V1::ReportImageLike < ActiveRecord::Base
	validates :report_image_id, presence: true, numericality: { greater_than_or_equal_to: 1 }

	belongs_to :user

	after_create :notify
	attr_accessor :notify_people

	after_initialize :default_values

  def default_values
    self.notify_people = true
  end

	def process_image_url(url)
		return url.sub! 's3.amazonaws.com/windfollow', 'windfollow.s3.amazonaws.com'
	end

	def notify
		if self.notify_people == true
			# get image
			image = Api::V1::ReportImage.find(self.report_image_id)
			# find user 
			user = Api::V1::User.find(self.user_id)
			# if it is not the report image author
			if self.user_id != image.user_id
				# create new notification
				notification = Api::V1::Notification.new
				notification.user_id = image.user_id
				notification.event_type = Api::V1::Notification::TYPE_REPORT_PHOTO_LIKE
				notification.content = {:event_user_id => user.id, :event_user_name => user.first_name + ' ' + user.last_name, :event_user_avatar => user.formated_avatar, :event_image_url => self.process_image_url(image.image.url), :report => image.report }.to_json
				notification.event_object_id = self.report_image_id
				notification.save
			end
		end
	end
end
