require 'sinatra'

set :items, {1 => "Channa Masala", 2 => "Chicken Tikka Masala", 3 => "Saag Paneer"}

get '/' do
  erb :index
end

get '/items' do
  filter = params['filter']

  if filter.nil?
    matched_items = items
  else
    matched_items = {}
    items.each do |id, name|
      if matches?(filter, name)
        matched_items[id] = name
      end
    end
  end

  erb :items, locals: {items: matched_items}
end

get '/items/new' do
  erb :new_item
end

def items
  settings.items
end

def matches?(filter, name)
  name.downcase.include?(filter.downcase)
end
