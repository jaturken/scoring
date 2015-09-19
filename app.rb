require 'sinatra'
require "./config/initializers/models"

get '/' do
 erb :home
end

post '/data' do
  email = params[:email]
  puts params
  # TODO: save user
  redirect '/'
end

get '/user/:id' do
  @user = User[params[:id]]
  erb :user
end

get '*' do
  erb :go_away
end
