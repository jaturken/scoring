require 'sidekiq'
require './config/initializers/models'
require './lib/parser/facebook'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end


require 'sidekiq/web'
run Sidekiq::Web
