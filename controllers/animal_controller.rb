require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animals')
require_relative('../models/owners')
also_reload('../models/*')

get '/animals' do
  @animals = Animal.all
  erb(:"animals/index")
end

post '/animals' do
  Animal.new(params).save
  redirect to '/animals'
end

get '/animals/new' do
  @owners = Owner.all
  erb(:"animals/new")
end

get '/animals/:id' do
  @animal = Animal.find(params['id'])
  @owners = Owner.all
  erb(:"animals/show")
end

get '/animals/:id/edit' do
  @owners = Owner.all
  @animal = Animal.find(params['id'])
  erb(:"animals/edit")
end

post '/animals/:id' do
  animal = Animal.new(params)
  animal.update
  redirect to "/animals/#{params['id']}"

end

post '/animals/:id/delete' do
  animal = Animal.find(params['id'])
  animal.delete
  redirect to '/animals'

end

post "/animals/:id/adopt" do
  animal = Animal.find(params["id"])
  animal.owner_id = params["owner_id"].to_i
  animal.update()
  redirect to "/animals/#{params['id']}"
end

post "/animals/:id/unassign" do
  animal = Animal.find(params["id"])
  animal.owner_id = nil
  animal.update()
  redirect to "/animals/#{params['id']}"
end
