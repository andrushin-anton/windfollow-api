class Api::V1::ReportImageComment < ActiveRecord::Base
	validates :report_image_id, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :content, presence: true

	belongs_to :user

	scope :recent, -> () { order('created_at DESC') }

	after_create :notify
	attr_accessor :notify_people

	after_initialize :default_values

  def default_values
    self.notify_people = true
  end

	def notify
		if self.notify_people == true
			# get image
			image = Api::V1::ReportImage.find(self.report_image_id)
			# find event user 
			user = Api::V1::User.find(self.user_id)
			# create new notification
			notification = Api::V1::Notification.new
			notification.user_id = image.user_id
			notification.event_type = Api::V1::Notification::TYPE_REPORT_PHOTO_COMMENT
			notification.content = { :event_user_id => user.id, :event_user_name => user.first_name + ' ' + user.last_name, :event_user_avatar => user.formated_avatar, :event_content => self.content, :report => image.report }.to_json
			notification.event_object_id = self.report_image_id
			notification.save
		end
	end
end
