require_relative('../models/animals')
require_relative('../models/owners')
require('pry')

Animal.delete_all
Owner.delete_all

owner1 = Owner.new({
  'first_name' => 'Steve',
  'last_name' => 'Irwin',
  'phone_number' => 555444777,
  'address' => '75 South Ripper road'
})

owner2 = Owner.new({
  'first_name' => 'Terry',
  'last_name' => 'Nutkins',
  'phone_number' => 555333888,
  'address' => '23 Otter Lane'
})

owner3 = Owner.new({
  'first_name' => 'Michaela',
  'last_name' => 'Strachan',
  'phone_number' => 555777999,
  'address' => '19 Safari Mill'
})


owner1.save
owner2.save
owner3.save


animal1 = Animal.new({
  'name' => 'Bouncer',
  'species' => 'Dog',
  'breed' => 'Labrador',
  'received_date' => '23/01/18',
  'adoptable' => true,
  'photo' => "/images/bouncer.png",
  'owner_id' => owner1.id
})

animal2 = Animal.new({
  'name' => 'Snowflake',
  'species' => 'Dolphin',
  'breed' => 'Bottlenose',
  'received_date' => '09/09/19',
  'adoptable' => true,
  'photo' => "/images/snowflake.png",
  'owner_id' => nil
})


animal3 = Animal.new({
  'name' => 'Bud',
  'species' => 'Dog',
  'breed' => 'Golden Retriever',
  'received_date' => '09/09/19',
  'adoptable' => false,
  'photo' => "/images/bud.png",
  'owner_id' => nil
})

animal1.save
animal2.save
animal3.save

binding.pry
nil
