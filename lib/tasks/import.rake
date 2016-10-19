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
		Api::V1::User.destroy_all

		i = 1

		result.each do |user|

			# Add user
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
			if user['avatar'] != '_none.jpg'
				user_model.avatar = open('http://www.gdeduet.ru/images/avatars/' + user['avatar'])
			end
			user_model.save

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
		Api::V1::Message.destroy_all

		i = 1

		result.each do |message|

			message_model = Api::V1::Message.new
			message_model.sender_id = message['from_id']
			message_model.recepient_id = message['to_id']
			message_model.content = message['message']
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
		Api::V1::Report.destroy_all
		Api::V1::ReportImage.destroy_all
		Api::V1::ReportComment.destroy_all

		i = 1

		# result.each do |report|

		# 	if report['spot_id'].to_i < 431
		# 		report_model = Api::V1::Report.new
		# 		report_model.notify_people = false
		# 		report_model.id = report['id']
		# 		report_model.spot_id = report['spot_id']
		# 		report_model.content = report['comment']
		# 		report_model.user_id = report['user_id']
		# 		report_model.place = report['location_name']
		# 		report_model.wind = report['mid_wind'].to_s + '-' + report['max_wind'].to_s
		# 		report_model.direction = report['direction']
		# 		report_model.updated_at = Time.at(report['created'].to_i).to_datetime
		# 		report_model.created_at = Time.at(report['created'].to_i).to_datetime
		# 		if report_model.save
		# 			# save report image
		# 			if report['photo'] != ''
		# 				report_image_model = Api::V1::ReportImage.new
		# 				report_image_model.user_id = report['user_id']
		# 				report_image_model.report_id = report_model.id
		# 				report_image_model.image = open('http://www.gdeduet.ru/images/reports/' + report['photo'])
		# 				report_image_model.save
		# 			end
		# 		end
		# 	end	
		# end

		puts 'Saved reports'

		# save report comments
		sleep(1)

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/report_comments')

		# Submit request
		result_comments = JSON.parse(open(uri).read)

		result_comments.each do |comment|
			report_comment_model = Api::V1::ReportComment.new
			report_comment_model.notify_people = false
			report_comment_model.report_id = comment['report_id']
			report_comment_model.user_id = comment['user_id']
			report_comment_model.content = comment['comment']
			report_comment_model.created_at = Time.at(comment['created'].to_i).to_datetime
			report_comment_model.updated_at = Time.at(comment['created'].to_i).to_datetime
			report_comment_model.save
		end

		puts 'Saved report comments'

		# save report likes
		sleep(1)

		# Prepare API request
		uri = URI.parse('http://www.gdeduet.ru/api/everything/22042016/report_likes')

		# Submit request
		result_likes = JSON.parse(open(uri).read)

		result_likes.each do |like|
			report_like_model = Api::V1::ReportLike.new
			report_like_model.notify_people = false
			report_like_model.report_id = like['report_id']
			report_like_model.user_id = like['user_id']
			report_like_model.save
		end

		puts 'Saved report likes'
	end
end