class Api::V1::Report < ActiveRecord::Base
	validates :direction, :inclusion => { :in => ['calm','e','ene','ese','n','ne','nne','nnw','nw','s','se','sse','ssw','sw','w','wnw','wsw'] }, :allow_blank => true

	has_many :report_comments
	has_many :report_likes
	has_many :report_images
	has_many :report_views_count
	belongs_to :user

	after_create :notify
	attr_accessor :notify_people

	after_initialize :default_values

	def default_values
		self.notify_people = true
	end

	def notify
		if self.notify_people == true

			send_push_notification = false
			
			# we are interested in wind reports only
			if (self.wind != '')
				# get report's spot
				spot = Api::V1::Spot.find(self.spot_id)
				# we are interested in reports assigned to one of the spots
				unless spot.nil?
					# get users subsribed to this spot
					user_spots = Api::V1::UserSpot.where('spot_id = ?', spot.id).all

					unless user_spots.nil?
						# loop through each of the user and send a personal notification
						user_spots.each do |user_spot|
							# check if the user is not that one who has created this report
							if user_spot.user_id != self.user_id
						
								# we are good to save notification
								# find event user 
								event_user = Api::V1::User.find(self.user_id)		
								# create new notification
								notification = Api::V1::Notification.new
								notification.user_id = user_spot.user_id
								notification.event_type = Api::V1::Notification::TYPE_NEW_REPORT
								notification.content = {:spot => spot, :direction => self.direction, :wind => self.wind, :event_user_id => event_user.id, :event_user_name => event_user.first_name + ' ' + event_user.last_name, :event_user_avatar => event_user.formated_avatar, :event_report_place => self.place }.to_json
								notification.event_object_id = self.id
								notification.save
								# update flag
								send_push_notification = true
								
							end
						end
					end
				end
			end

			# Create a new delayed job
			if send_push_notification == true
				SendReportPushJob.set(wait: 5.seconds).perform_later()
			end
		end	
	end

	# calculates the great-circle distance between two points – that is,
	# the shortest distance over the earth’s surface – giving an ‘as-the-crow-flies’
	# distance between the points (ignoring any hills they fly over, of course!)
	# retuns distans in km
	def self.haversine(lat1, lon1, lat2, lon2) 

		r = 6371e3; # metres (Earth radius) 
		φ1 = self.toRadians(lat1);
		φ2 = self.toRadians(lat2);
		Δφ = self.toRadians(lat2-lat1);
		Δλ = self.toRadians(lon2-lon1);

		a = Math::sin(Δφ/2) * Math::sin(Δφ/2) + Math::cos(φ1) * Math::cos(φ2) * Math::sin(Δλ/2) * Math::sin(Δλ/2);

		c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a));

		d = ((r * c) * 0.001).round(2);
	end

	def self.toRadians(degrees)
		degrees * Math::PI / 180
	end
end
