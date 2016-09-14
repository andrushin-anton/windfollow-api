class Api::V1::Report < ActiveRecord::Base
	validates :direction, :inclusion => { :in => ['calm','e','ene','ese','n','ne','nne','nnw','nw','s','se','sse','ssw','sw','w','wnw','wsw'] }, :allow_blank => true

	has_many :report_comments
	has_many :report_likes
	has_many :report_images
	belongs_to :user

	after_create :notify

	def notify
		# get report's spot
		spot = Api::V1::Spot.find(self.spot_id)

		unless spot.nil?
			# get users with alerts enabled
			Api::V1::Alert.find_each.each do |alert|

				# check if the user is not that one who has created this report
				if alert.user_id != self.user_id

					# find out if in time range
					# getting user's datetime by timezone configured
					user_timezone = alert.user.get_timezone_value(alert.user.timezone)
					user_datetime = Time.zone.now + user_timezone.hours
					user_hour = user_datetime.strftime('%H')
					
					# it should be more or equal to the start hour and less or equat to the end hour in user's config
					if (user_hour.to_i >= alert.time_alert.split(',', 2).first.to_i) && (user_hour.to_i <= alert.time_alert.split(',', 2).last.to_i)
						
						# get users in distance range
						user_lat = alert.user.geo_lat.to_f
						user_lon = alert.user.geo_lon.to_f

						# spot's geolocation
						spot_lat = spot.geo_lat.to_f
						spot_lon = spot.geo_lon.to_f

						distance = self.haversine(user_lat, user_lon, spot_lat, spot_lon)

						if alert.distance >= distance
							# we are good to save notification
							# find event user 
							event_user = Api::V1::User.find(self.user_id)
							
							# create new notification
							notification = Api::V1::Notification.new
							notification.user_id = alert.user_id
							notification.event_type = Api::V1::Notification::TYPE_NEW_REPORT
							notification.content = {:distance => distance, :event_user_id => event_user.id, :event_user_name => event_user.first_name + ' ' + event_user.last_name, :event_user_avatar => event_user.formated_avatar, :event_report_place => self.place }.to_json
							notification.event_object_id = self.id
							notification.save
						end
					end
				end
			end
		end
	end

	# calculates the great-circle distance between two points – that is,
	# the shortest distance over the earth’s surface – giving an ‘as-the-crow-flies’
	# distance between the points (ignoring any hills they fly over, of course!)
	# retuns distans in km
	def haversine(lat1, lon1, lat2, lon2) 

		r = 6371e3; # metres (Earth radius) 
    φ1 = self.toRadians(lat1);
    φ2 = self.toRadians(lat2);
    Δφ = self.toRadians(lat2-lat1);
    Δλ = self.toRadians(lon2-lon1);

    a = Math::sin(Δφ/2) * Math::sin(Δφ/2) + Math::cos(φ1) * Math::cos(φ2) * Math::sin(Δλ/2) * Math::sin(Δλ/2);

    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a));

    d = ((r * c) * 0.001).round(2);
	end

	def toRadians(degrees)
		degrees * Math::PI / 180
	end
end
