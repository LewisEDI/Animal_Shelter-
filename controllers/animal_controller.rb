require('sinatra')
require('sinatra/contrib/all')
require_relative('models/animals')
also_reload('./models/*')

get '/animals' do
  @animals = animals.all
  erb(:index)
end

post '/animals' do
  Animal.new(params).save
  redirect to '/animals'
end

get '/animals/new' do
  @owners = owners.all
  erb(:new)
end

get '/animals/:id' do
  @animal = Animal.find_by_animal_id(params['id'])
  erb(:show)
end

get '/animals/:id/edit' do
  @owners = Owners.all
  @student = Animals.find_by_animal_id(params['id'])
  erb(:edit)
end

post '/animals/:id' do
  animal = Animal.new(params)
  animal.update
  redirect to "/animal/#{params['id']}"
  #consider redirecting to a confirmation screen later.
end

post '/animals/:id/delete' do
  animal = Animal.find(params['id'])
  animal.delete
  redirect to '/animals'
  #consider redirecting to a confirmation screen later.
end
