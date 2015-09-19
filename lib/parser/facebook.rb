class FacebookParser
  include Sidekiq::Worker
  sidekiq_options :queue => :facebook

  def perform(user_id)
    user = User[user_id]
    p "User #{user.id} - #{user.email}"
  end
end
