require 'sinatra'

get '/' do
  erb :index
end

get '/items' do
  "This is the items page"
end