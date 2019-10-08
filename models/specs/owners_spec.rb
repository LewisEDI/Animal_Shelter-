require("minitest/autorun")
require_relative("../owners")
require_relative("../animals")
require('pry')

class TestOwners < MiniTest::Test

  def setup

    @owner1 = Owner.new({
      'first_name' => 'Steve',
      'last_name' => 'Irwin',
      'phone_number' => 555444777,
      'address' => '75 south ripper road'
    })

    @owner2 = Owner.new({
      'first_name' => 'Terry',
      'last_name' => 'Nutkins',
      'phone_number' => 555333888,
      'address' => '23 otter lane'
    })

    @owner3 = Owner.new({
      'first_name' => 'David',
      'last_name' => 'Attenborough',
      'phone_number' => 555777999,
      'address' => '19 croaky mill'
    })


    @owner1.save
    @owner2.save
    @owner3.save


    animal1 = Animal.new({
      'name' => 'Bouncer',
      'species' => 'Dog',
      'breed' => 'labrador',
      'age' => 4,
      'received_date' => '23/01/18',
      'adoptable' => true,
      'photo' => 'link to be added',
      'owner_id' => @owner1.id
    })

    animal2 = Animal.new({
      'name' => 'Maisie',
      'species' => 'Cat',
      'breed' => 'Tabby',
      'age' => 2,
      'received_date' => '09/09/19',
      'adoptable' => true,
      'photo' => 'link to be added',
      'owner_id' => @owner1.id
    })

    animal3 = Animal.new({
      'name' => 'Jake',
      'species' => 'Snake',
      'breed' => 'Python',
      'age' => 12,
      'received_date' => '20/04/16',
      'adoptable' => false,
      'photo' => 'link to be added',
      'owner_id' => nil
    })

    animal1.save
    animal2.save
    animal3.save

  end

  def test_owners_animals()
    result = @owner1.owners_animals(@owner1.id).count
    assert_equal(2, result)
    puts result
  end

  def test_name()
    result = Owner.find_name(1)
    assert_equal("Steve Irwin", result)
  end


end
