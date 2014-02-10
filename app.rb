require 'sinatra'

set :items, {1 => "Channa Masala", 2 => "Chicken Tikka Masala", 3 => "Saag Paneer"}

get '/' do
  erb :index
end

get '/items' do
  puts "*" * 30
  puts params['filter']
  erb :items, locals: {items: settings.items}
end
