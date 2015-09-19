class FacebookParser

  include Sidekiq::Worker
  sidekiq_options :queue => :facebook
  OAUTH_API = 'CAACEdEose0cBACD8r1hZBSaqrN8QiABcNfG1azVP8gngjT6nXUBfCxkZCyxatY0Y2F3o58io5mPDqmHrUoaVNZBRGUhJQMSxTMDJq6TXbPIrjwaHwAQvbvdP8MDgoBuouI1doar42QqwxykfSbZC5gFeThUVCK4kJEBcXZC0QAdjcHmyJ1qq1NLZARspQ4wgP9VKIObe8lLLgOVdes2c9a'
  APP_ID = 1647966302155628
  APP_SECRET = 'f24d034dde284bd1953ccd1d27ea1238'

  def perform(user_id)
    user = User[user_id]
    p "User #{user.id} - #{user.email}"
  end
end
