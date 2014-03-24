require 'sinatra'
require './lib/items_repository'

ITEMS_REPOSITORY = ItemsRepository.new

get '/' do
  erb :index
end

get '/items' do
  erb :items, locals: {items: ITEMS_REPOSITORY.items(params['filter'])}
end

get '/items/new' do
  erb :new_item
end

post '/items' do
  ITEMS_REPOSITORY.add(params['item_name'])
  redirect to('/items')
end

get '/items/:id' do
  item = ITEMS_REPOSITORY.find(params[:id].to_i)
  if item.nil?
    halt 404, erb(:not_found)
  else
    erb :show_item, locals: {item: item}
  end
end

get '/items/:id/edit' do
  item = ITEMS_REPOSITORY.find(params[:id].to_i)
  if item.nil?
    halt 404, erb(:not_found)
  else
    erb :edit_item, locals: {item: item}
  end
end

put '/items/:id' do
  ITEMS_REPOSITORY.update(params[:id].to_i, params['item_name'])
  redirect to('/items')
end

delete '/items/:id' do
  # no need to return a 404 because delete is idempotent.
  # if the item doesn't exist then delete doesn't have to do it's job
  ITEMS_REPOSITORY.delete(params[:id].to_i)
  redirect to('/items')
end


