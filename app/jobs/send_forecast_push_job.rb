require 'json'

class SendForecastPushJob < ActiveJob::Base
  queue_as :default

  def perform()
	# Create new RailsPushNotifications app for I devices
	app = RailsPushNotifications::APNSApp.new
	app.apns_dev_cert = File.read('path/to/your/development/certificate.pem')
	app.apns_prod_cert = File.read('path/to/your/production/certificate.pem')
	app.sandbox_mode = true
	app.save

  	# Find all notifications that need to be sent
  	Api::V1::Notification.where('event_type = ?', Api::V1::Notification::TYPE_FORECAST_ALERT).order('created_at asc').find_each do |alert|
		
		# devices tokens
  		tokens = []
      	# Find user's device token
      	Api::V1::Device.where('user_id = ?', alert.user_id).find_each do |device|
      		# Add user's token to tokens array
      		tokens << device.token	
      	end

      	unless tokens.empty?
			data = JSON.parse(alert.content)			
      		# Add new notification			
	      	app.notifications.create(
				destinations: tokens,
				data: { aps: { alert: 'New forecast alert => spot:' + data['spot']['name'] + ' when:' + data['vt'], sound: 'true', badge: 1 } }
			)

			# Delete notification from notifications table - it will be delivered by push notification
      		alert.destroy	
      	end
	end
	# Send push notifications
	app.push_notifications
  end
end