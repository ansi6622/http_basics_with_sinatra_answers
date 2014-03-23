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
  settings.items_repository.add(params['item_name'])
  redirect to('/items')
end

get '/items/:id' do
  item = settings.items_repository.find(params[:id].to_i)
  if item.nil?
    halt 404, erb(:not_found)
  else
    erb :show_item, locals: {item: item}
  end
end

get '/items/:id/edit' do
  item = settings.items_repository.find(params[:id].to_i)
  if item.nil?
    halt 404, erb(:not_found)
  else
    erb :edit_item, locals: {item: item}
  end
end

put '/items/:id' do
  settings.items_repository.update(params[:id].to_i, params['item_name'])
  redirect to('/items')
end

delete '/items/:id' do
  # no need to return a 404 because delete is idempotent.
  # if the item doesn't exist then delete doesn't have to do it's job
  settings.items_repository.delete(params[:id].to_i)
  redirect to('/items')
end


