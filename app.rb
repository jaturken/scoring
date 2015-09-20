require 'sinatra'
require "sidekiq"
require "./config/initializers/models"
require "./config/initializers/parsers"
require "./config/initializers/constants"
require "./lib/vkontakte_searcher"

get '/' do
 erb :home
end

post '/data' do
  email = params[:email]
  user = User.create(email: email)
  FacebookParser.perform_async(user.id)
  redirect "/user/#{user.id}"
end

get '/user/:id' do
  @user = User[params[:id]]
  erb :user
end

get '*' do
  erb :go_away
end
