require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animals')
require_relative('../models/owners')
also_reload('../models/*')

get '/owners' do
  @owners = Owner.all
  erb(:"owners/index")
end

post '/owners' do
  Owner.new(params).save
  redirect to '/owners'
end

get '/owners/new' do
  @animals = Animal.all
  erb(:"owners/new")
end

get '/owners/:id' do
  @owner = Owner.find(params['id'])
  @animals = Animal.all
  erb(:"owners/show")
end

get '/owners/:id/edit' do
  @animals= Animal.all
  @owner = Owner.find(params['id'])
  erb(:"owners/edit")
end

post '/owners:id' do
  owner = Owner.new(params)
  owner.update
  redirect to "/owners/#{params['id']}"

end

post '/owners/:id/delete' do
  owner = Owner.find(params['id'])
  owner.delete
  redirect to '/owners'

end
