require_relative( '../db/sql_runner' )

class Animal

  attr_accessor :name, :species, :breed, :recieved_date, :adoptable, :owner_id
  attr_reader :id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @breed = options['breed']
    @recieved_date = options['recieved_date']
    @adoptable = options['adoptable']
    @owner_id = options['owner_id']


  end

  def save()
    sql = "INSERT INTO animals
    (
      name,
      species,
      breed,
      recieved_date,
      adoptable,
      owner_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6
    )
    RETURNING id"
    values = [@name, @species, @breed, @recieved_date, @adoptable, @owner_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i

  end

  def delete()
    sql = "DELETE FROM animals
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def owner()
    owner = Owner.find_by_owner_id(@owner_id)
    return owner
  end

  def update()
    sql = "UPDATE animals
    SET
    (
      name,
      species,
      breed,
      age,
      recieved_date,
      adoptable,
      owner_id
      ) =
      (
        $1, $2, $3, $4, $5, $6, $7
      )
      WHERE id = $8"
      values = [@name, @species, @breed, @age, @recieved_date, @adoptable, @owner_id, @id]
      SqlRunner.run(sql, values)
    end

    def self.delete()
      sql = "DELETE * FROM animals"
      SqlRunner.run(sql)
    end

  def self.find_by_animal_id(id)
    sql = "SELECT * FROM animals
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    animal = Animal.new(result)
    return animal
  end

  def self.find_by_owner_id(id)
    sql = "SELECT * FROM animals
    WHERE owner_id = $1"
    values = [owner_id]
    animals = SqlRunner.run(sql ,values)
    animals_hash = []
    for animal in animals
      animals_hash.push(Animal.new(animal))
    end
    return animals_hash
  end

  def self.find_by_species(id)
    sql = "SELECT * FROM animals
    WHERE species = $1"
    values = [species]
    result = SqlRunner.run(sql ,values).first
    animal = Animal.new(result)
    return animal
  end

  def self.show_all_for_loop()
    sql = "SELECT * FROM animals"
    animals = SqlRunner.run( sql )
    animals_hash = []
    for animal in animals
      animals_hash.push(Animal.new(animal))
    end
    return animals_hash

  end

  end
