# Preview all emails at http://localhost:3000/rails/mailers/api/v1/wind_mailer
class Api::V1::WindMailerPreview < ActionMailer::Preview
	def password_refresh
		Api::V1::WindMailer.password_refresh(Api::V1::User.first, '45887878')
	end
end
