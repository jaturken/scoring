class VkontakteParser

  include Sidekiq::Worker
  sidekiq_options :queue => :vkontakte
  APP_ID = 5075731
  KEY = 'J6krEcwIzHGaBnA0dzsn'

  def perform(user_id)
    user = User[user_id]
    p "User #{user.id} - #{user.email}"
  end
end
