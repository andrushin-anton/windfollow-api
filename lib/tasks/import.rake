namespace :scraper do

  desc 'Import data from old db'

	task users: :environment do
		require 'open-uri'
		require 'json'

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/users')

		# Submit request
		result = JSON.parse(open(uri).read)

		# Clear old data
		# Api::V1::User.destroy_all

		i = 1

		result.each do |user|

			# Add user
			unless Api::V1::User.where('email = ? ', user['email']).first
				user_model = Api::V1::User.new
				user_model.id = user['id']
				user_model.email = user['email']
				user_model.password = user['password']
				user_model.first_name = user['firstname']
				user_model.last_name = user['lastname']
				user_model.rating = user['rating']
				user_model.about = ''
				user_model.birth_date = user['birthday']
				if user['gender'] = 'male'
					user_model.gender = 'm'
				else
					user_model.gender = 'f'
				end
				user_model.phone = user['phone']
				user_model.web_site = user['website']
				user_model.country = ''
				user_model.city = ''
				user_model.wind = 'm/s'
				user_model.temp = 'c'
				user_model.timezone = 'UTC +00:00'
				if user['avatar'] != '_none_.jpg'
					sleep(0.3)
					user_model.avatar = open('http://www.gdeduet.ru/images/avatars/' + user['avatar'])
				end
				def user_model.encrypt_password
					# overwrite/ do nothing because we don't need to encrypt password that has been encrypted
				end
				user_model.save	
			end				
		end
		puts 'Saved users'
	end

	task messages: :environment do
		require 'open-uri'
		require 'date'
		require 'json'

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/mail')

		# Submit request
		result = JSON.parse(open(uri).read)

		# Clear old data
		Api::V1::Conversation.destroy_all
		Api::V1::Message.destroy_all

		i = 1

		result.each do |message|

			# check if conversation exists, if not - create it 
			if Api::V1::Conversation.between(message['from_id'], message['to_id']).present?
				conversation = Api::V1::Conversation.between(message['from_id'], message['to_id']).first
			else
				conversation = Api::V1::Conversation.new
				conversation.sender_id = message['from_id']
				conversation.recipient_id = message['to_id']
				conversation.save
			end

			# save message
			message_model = conversation.messages.new		
			message_model.user_id = message['from_id']
			message_model.body = message['message']
			message_model.read = true
			message_model.created_at = Time.at(message['created'].to_i).to_datetime
			message_model.updated_at = Time.at(message['created'].to_i).to_datetime
			message_model.save			
		end
		puts 'Saved messages'
	end

	task reports: :environment do
		require 'open-uri'
		require 'date'
		require 'json'

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/reports')

		# Submit request
		result = JSON.parse(open(uri).read)

		# Clear old data
		# Api::V1::Report.destroy_all
		# Api::V1::ReportImage.destroy_all
		Api::V1::ReportComment.destroy_all

		accepted_reports = []

		i = 1

		result.each do |report|

			if report['spot_id'].to_i < 431
				accepted_reports << report['id']
				unless Api::V1::Report.where('id = ? ', report['id']).first
					report_model = Api::V1::Report.new
					report_model.notify_people = false
					report_model.id = report['id']
					report_model.spot_id = report['spot_id']
					report_model.content = report['comment']
					report_model.user_id = report['user_id']
					report_model.place = report['location_name']
					report_model.wind = report['mid_wind'].to_s + '-' + report['max_wind'].to_s
					report_model.direction = report['direction']
					report_model.updated_at = Time.at(report['created'].to_i).to_datetime
					report_model.created_at = Time.at(report['created'].to_i).to_datetime
					if report_model.save
						# save report image
						if report['photo'] != ''
							sleep(0.3)
							report_image_model = Api::V1::ReportImage.new
							report_image_model.user_id = report['user_id']
							report_image_model.report_id = report_model.id
							report_image_model.image = open('http://www.gdeduet.ru/images/reports/' + report['photo'])
							report_image_model.save
						end
					end
				end
			end	
		end

		puts 'Saved reports'

		# save report comments
		sleep(1)

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/report_comments')

		# Submit request
		result_comments = JSON.parse(open(uri).read)

		result_comments.each do |comment|
			if accepted_reports.include? comment['report_id']
				report_comment_model = Api::V1::ReportComment.new
				report_comment_model.notify_people = false
				report_comment_model.report_id = comment['report_id']
				report_comment_model.user_id = comment['user_id']
				report_comment_model.content = comment['comment']
				report_comment_model.created_at = Time.at(comment['created'].to_i).to_datetime
				report_comment_model.updated_at = Time.at(comment['created'].to_i).to_datetime
				report_comment_model.save
			end
		end

		puts 'Saved report comments'

		# save report likes
		sleep(1)

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/report_likes')

		# Submit request
		result_likes = JSON.parse(open(uri).read)

		result_likes.each do |like|
			if accepted_reports.include? like['report_id']
				report_like_model = Api::V1::ReportLike.new
				report_like_model.notify_people = false
				report_like_model.report_id = like['report_id']
				report_like_model.user_id = like['user_id']
				report_like_model.save
			end
		end

		puts 'Saved report likes'
	end

	task user_photos: :environment do
		require 'open-uri'
		require 'json'

		# Prepare API request (ALBUM)
		uri_albom = URI.parse('http://www.gdeduet.ru/api/everything/22042016/user_photo_albom')
		# Submit request
		result_album = JSON.parse(open(uri_albom).read)

		sleep(0.3)

		# Prepare API request (PHOTO)
		uri_photos = URI.parse('http://www.gdeduet.ru/api/everything/22042016/user_photos')
		# Submit request
		result_photos = JSON.parse(open(uri_photos).read)

		sleep(0.3)

		# Prepare API request (COMMENTS)
		uri_photo_comments = URI.parse('http://www.gdeduet.ru/api/everything/22042016/user_photo_comments')
		# Submit request
		result_photo_comments = JSON.parse(open(uri_photo_comments).read)

		sleep(0.3)

		# Prepare API request (LIKES)
		uri_photo_likes = URI.parse('http://www.gdeduet.ru/api/everything/22042016/user_photo_likes')
		# Submit request
		result_photo_likes = JSON.parse(open(uri_photo_likes).read)

		sleep(0.3)

		# Prepare API request (SPOT PHOTOS)
		uri_spot_photos = URI.parse('http://www.gdeduet.ru/api/everything/22042016/spot_photos')
		# Submit request
		result_spot_photos = JSON.parse(open(uri_spot_photos).read)		

		sleep(0.3)

		# Prepare API request (SPOT PHOTO LIKES)
		uri_spot_photo_likes = URI.parse('http://www.gdeduet.ru/api/everything/22042016/spot_photo_likes')
		# Submit request
		result_spot_photo_likes = JSON.parse(open(uri_spot_photo_likes).read)		


		i = 1

		result_spot_photos.each do |spot_photo|
			if spot_photo['spot_id'].to_i < 431
				report_model = Api::V1::Report.new
				report_model.notify_people = false
				report_model.spot_id = spot_photo['spot_id']
				report_model.user_id = spot_photo['user_id']
				report_model.updated_at = Time.at(spot_photo['created'].to_i).to_datetime
				report_model.created_at = Time.at(spot_photo['created'].to_i).to_datetime
				if report_model.save
					sleep(0.3)
					report_image_model = Api::V1::ReportImage.new
					report_image_model.user_id = spot_photo['user_id']
					report_image_model.report_id = report_model.id
					report_image_model.image = open('http://www.gdeduet.ru/images/spots_photogallery/' + spot_photo['img'])
					if report_image_model.save
						result_spot_photo_likes.each do |spot_like|
							if spot_like['photo_id'] == spot_photo['id']
									report_image_like_model = Api::V1::ReportImageLike.new
									report_image_like_model.notify_people = false
									report_image_like_model.user_id = spot_like['user_id']
									report_image_like_model.report_image_id = report_image_model.id
									report_image_like_model.save
							end
						end
					end
				end				
			end
		end

		puts 'Saved spot photos'

		result_album.each do |album|
			album_spot_id = album['spot_id']

			if album['spot_id'].to_i < 431
				album_spot_id = 0
			end
			report_model = Api::V1::Report.new
			report_model.notify_people = false
			report_model.spot_id = album_spot_id
			report_model.content = album['title']
			report_model.user_id = album['user_id']
			report_model.updated_at = Time.at(album['created'].to_i).to_datetime
			report_model.created_at = Time.at(album['created'].to_i).to_datetime
			if report_model.save
				# save report image
				result_photos.each do |photo|
					if photo['albom_id'] == album['id']
						sleep(0.3)
						report_image_model = Api::V1::ReportImage.new
						report_image_model.user_id = album['user_id']
						report_image_model.report_id = report_model.id
						report_image_model.image = open('http://www.gdeduet.ru/images/user_photos/' + photo['img'])
						if report_image_model.save
							# Image Comments
							result_photo_comments.each do |comment|
								if photo['id'] == comment['photo_id']
									report_image_comment_model = Api::V1::ReportImageComment.new
									report_image_comment_model.notify_people = false
									report_image_comment_model.report_image_id = report_image_model.id
									report_image_comment_model.user_id = comment['user_id']
									report_image_comment_model.content = comment['comment']
									report_image_comment_model.updated_at = Time.at(comment['created'].to_i).to_datetime
									report_image_comment_model.created_at = Time.at(comment['created'].to_i).to_datetime
									report_image_comment_model.save
								end
							end

							# Image Likes
							result_photo_likes.each do |like|
								if photo['id'] == like['photo_id']
									report_image_like_model = Api::V1::ReportImageLike.new
									report_image_like_model.notify_people = false
									report_image_like_model.user_id = like['user_id']
									report_image_like_model.report_image_id = report_image_model.id
									report_image_like_model.save
								end
							end
						end
					end
				end
			end
		end
		puts 'Saved user photos'
	end

	task favorites: :environment do
		require 'open-uri'
		require 'json'

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/user_spots')

		# Submit request
		result = JSON.parse(open(uri).read)

		# Clear old data
		Api::V1::FavoriteSpot.destroy_all

		i = 1

		result.each do |favorite_spot|

			if favorite_spot['spot_id'].to_i < 431
				favorite_model = Api::V1::FavoriteSpot.new
			  favorite_model.spot_id = favorite_spot['spot_id']
			  favorite_model.user_id = favorite_spot['user_id']
			  favorite_model.save
			end
		end
		puts 'Saved favorite spots'
	end

	task friends: :environment do
		require 'open-uri'
		require 'json'

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/friends')

		# Submit request
		result = JSON.parse(open(uri).read)

		# Clear old data
		Api::V1::Follower.destroy_all

		i = 1

		result.each do |friend|

			follower_model = Api::V1::Follower.new
		  follower_model.follower_id = friend['from_id']
		  follower_model.user_id = friend['to_id']
		  follower_model.save

		  if friend['status'].to_i == 1
		  	follower_model = Api::V1::Follower.new
   		  follower_model.follower_id = friend['to_id']
	  	  follower_model.user_id = friend['from_id']
		    follower_model.save
		  end
			
		end
		puts 'Saved friends'
	end

	task spot_names: :environment do
		require 'open-uri'
		require 'json'

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/spots')

		# Submit request
		result = JSON.parse(open(uri).read)


		result.each do |spot|

			if spot['id'].to_i <= 431
				windfollow_spot = Api::V1::Spot.find(spot['id'].to_i)

				unless windfollow_spot.nil?
					if windfollow_spot.name == '' || windfollow_spot.name == nil?
						Api::V1::Spot.where('id = ?', spot['id'].to_i).update_all(name: spot['name'])
					end
				end
			end

		end
		puts 'Updated spots'
	end
end