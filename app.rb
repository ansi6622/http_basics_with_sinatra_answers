require 'sinatra'
require './lib/items_repository'

set :items_repository, ItemsRepository.new

get '/' do
  erb :index
end

get '/items' do
  erb :items, locals: {items: settings.items_repository.items(params['filter'])}
end

get '/items/new' do
  erb :new_item
end

post '/items' do
  max_id = items.keys.max
  items[max_id + 1] = params['item_name']
  redirect to('/items')
end

get '/items/:id' do
  item_name = items[params[:id].to_i]

  if item_name.nil?
    halt 404, erb(:not_found)
  else
    erb :show_item, locals: {id: params[:id], item_name: item_name}
  end
end

get '/items/:id/edit' do
  item_name = items[params[:id].to_i]
  if item_name.nil?
    halt 404, erb(:not_found)
  else
    erb :edit_item, locals: {id: params[:id], item_name: item_name}
  end
end

put '/items/:id' do
  items[params[:id].to_i] = params['item_name']
  redirect to('/items')
end

delete '/items/:id' do
  # no need to return a 404 because delete is idempotent.
  # if the item doesn't exist then delete doesn't have to do it's job
  items.delete(params[:id].to_i)
  redirect to('/items')
end

def items
  settings.items
end


