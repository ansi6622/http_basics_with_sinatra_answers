require 'sinatra'

set :items, {1 => "Channa Masala", 2 => "Chicken Tikka Masala", 3 => "Saag Paneer"}

get '/' do
  erb :index
end

get '/items' do
  filter = params['filter']

  if filter.nil?
    matched_items = settings.items
  else
    matched_items = {}
    settings.items.each do |id, name|
      if name.downcase.include?(filter.downcase)
        matched_items[id] = name
      end
    end
  end

  erb :items, locals: {items: matched_items}
end
