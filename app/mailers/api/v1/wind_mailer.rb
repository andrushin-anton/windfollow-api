class Api::V1::WindMailer < ApplicationMailer
	def password_refresh(user, new_password)
		@user = user
		@new_password = new_password
    mail(to: @user.email, subject: 'New Password')
	end

	def support(user, message)
		@user = user
		@message = message
    mail(to: 'hello@windfollow.com', subject: 'New support message')
	end
end
