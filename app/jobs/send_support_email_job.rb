class SendSupportEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, message)
  	@user = user
  	Api::V1::WindMailer.support(@user, message).deliver_later
  end
end
