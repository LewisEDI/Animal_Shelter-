require_relative( '../db/sql_runner' )

class Owner

  attr_reader :id, :first_name, :last_name, :phone_number, :address

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @phone_number = options['phone_number'].to_i
    @address = options['address']

  end

  def joined_name()
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
      values = [@first_name, @last_name, @phone_number, @address, @id]
      SqlRunner.run(sql, values)
    end

    def number_of_animals()
      sql = "SELECT * FROM animals
      WHERE owner_id = $1"
      values = [id]
      animals = SqlRunner.run(sql ,values)
      animals_hash = []
      for animal in animals
        animals_hash.push(Animal.new(animal))
      end
      return animals_hash.length
    end

    def owners_animals()
      sql = "SELECT * FROM animals
      WHERE owner_id = $1"
      values = [id]
      animals = SqlRunner.run(sql ,values)
      animals_hash = []
      for animal in animals
        animals_hash.push(Animal.new(animal))
      end
      return animals_hash
    end

    def self.delete_all()
      sql = "DELETE FROM owners"
      SqlRunner.run(sql)
    end

    def self.find(id)
      sql = "SELECT * FROM owners
      WHERE id = $1"
      values = [id]
      result = SqlRunner.run(sql ,values).first
      owner = Owner.new(result)
      return owner
    end

    def self.find_name(id)
      sql = "SELECT * FROM owners
      WHERE id = $1"
      values = [id]
      result = SqlRunner.run(sql ,values).first
      owner = Owner.new(result)
      return owner.joined_name
    end

    def self.find_by_owner_name(first_name, last_name)
      sql = "SELECT * FROM owners
      WHERE first_name = $1 AND last_name = $2"
      values = [first_name, last_name]
      result = SqlRunner.run(sql ,values)
      owners = []
      for owner in result
        owners.push(Owner.new(owner))
      end
      return owners
    end

    def self.all()
      sql = "SELECT * FROM owners"
      result = SqlRunner.run( sql )
      owners = []
      for owner in result
        owners.push(Owner.new(owner))
      end
      return owners

    end


  end
