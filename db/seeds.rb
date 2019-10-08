require_relative('../models/animals')
require_relative('../models/owners')
require('pry')

Animal.delete_all
Owner.delete_all

owner1 = Owner.new({
  'first_name' => 'Steve',
  'last_name' => 'Irwin',
  'phone_number' => 555444777,
  'address' => '75 south ripper road'
})

owner2 = Owner.new({
  'first_name' => 'Terry',
  'last_name' => 'Nutkins',
  'phone_number' => 555333888,
  'address' => '23 otter lane'
})

owner3 = Owner.new({
  'first_name' => 'David',
  'last_name' => 'Attenborough',
  'phone_number' => 555777999,
  'address' => '19 croaky mill'
})


owner1.save
owner2.save
owner3.save


animal1 = Animal.new({
  'name' => 'Bouncer',
  'species' => 'Dog',
  'breed' => 'labrador',
  'received_date' => '23/01/18',
  'adoptable' => true,
  'photo' => 'link to be added',
  'owner_id' => owner1.id
})

animal2 = Animal.new({
  'name' => 'Maisie',
  'species' => 'Cat',
  'breed' => 'Tabby',
  'received_date' => '09/09/19',
  'adoptable' => true,
  'photo' => 'link to be added',
  'owner_id' => owner2.id
})

animal3 = Animal.new({
  'name' => 'Jake',
  'species' => 'Snake',
  'breed' => 'Python',
  'received_date' => '20/04/16',
  'adoptable' => false,
  'photo' => 'link to be added',
  'owner_id' => nil
})

animal4 = Animal.new({
  'name' => 'Fido',
  'species' => 'Dog',
  'breed' => 'Alsation',
  'received_date' => '09/09/19',
  'adoptable' => true,
  'photo' => 'link to be added',
  'owner_id' => nil
})

animal1.save
animal2.save
animal3.save
animal4.save

binding.pry
nil
