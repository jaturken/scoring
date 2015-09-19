require 'sinatra'
require "./config/initializers/models"


get '/' do
  # Email input
 #"Tatiana go work"
 erb :home
end

post '/data' do
  email = params[:email]

# TODO: save email, redirect to user page
end

get '/user/:id' do
  # Display user data
end

get '*' do
  erb :go_away
end
