require 'sinatra'
require "./config/initializers/models"

get '/' do
 erb :home
end

post '/data' do
  email = params[:email]
  user = User.create(email: params[:email])
  redirect "/user/#{user.id}"
end

get '/user/:id' do
  @user = User[params[:id]]
  erb :user
end

get '*' do
  erb :go_away
end
