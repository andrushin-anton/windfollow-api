class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, new_password)
  	@user = user
  	Api::V1::WindMailer.password_refresh(@user, new_password).deliver_later
  end
end
