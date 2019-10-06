require_relative( '../db/sql_runner' )

class Owner

  attr_accessor :first_name, :last_name, :phone_number, :address
  attr_reader: :id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @phone_number = options['phone_number']
    @address = options['address']

  end

  def first_name_last_name()
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = "INSERT INTO owners
    (
      first_name,
      last_name,
      phone_number,
      address
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@first_name, @last_name, @phone_number, @address]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def delete()
    sql = "DELETE FROM owners
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE owners
    SET
    (
      first_name,
      last_name,
      phone_number,
      address
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [@first_name, @last_name, @phone_number, @address]
      SqlRunner.run(sql, values)
    end

    def number_of_animals(owner_id)
      sql = "SELECT * FROM animals
      WHERE owner_id = $1"
      values = [owner_id]
      animals = SqlRunner.run(sql ,values)
      animals_hash = []
      for animal in animals
        animals_has.push(Animal.new(animal))
      end
      return owner_hash.length
    end

    def self.delete()
      sql = "DELETE * FROM owners"
      SqlRunner.run(sql)
    end

    def self.find_by_owner_id(id)
      sql = "SELECT * FROM owners
      WHERE id = $1"
      values = [id]
      result = SqlRunner.run(sql ,values).first
      animal = Owner.new(result)
      return animal
    end

    def self.find_by_owner_name(first_name, last_name)
      sql = "SELECT * FROM owners
      WHERE first_name = $1 AND last_name = $2"
      values = [first_name, last_name]
      owner_by_name = SqlRunner.run(sql ,values)
      owner_hash = []
      for owner in owner_by_name
        owner_hash.push(Owner.new(owner))
      end
      return owner_hash
    end

    def self.show_all_for_loop()
      sql = "SELECT * FROM owners"
      owners = SqlRunner.run( sql )
      owners_hash = []
      for owner in owners
        owners_hash.push(Owner.new(owner)
      end
      return owners_hash

    end


  end
