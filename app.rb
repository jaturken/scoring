require 'sinatra'


get '/' do
  # Email input
 "Tatiana go work"
end

post '/data' do
# TODO: save email, redirect to user page
end

get '/user/:id' do
  # Display user data
end

get '*' do
  erb :go_away
end
