require_relative( '../db/sql_runner' )

class Animal

  attr_reader :id, :name, :species, :breed, :received_date, :adoptable, :photo
  attr_accessor :owner_id



  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @breed = options['breed']
    @received_date = options['received_date']
    @adoptable = options['adoptable']
    @photo = options['photo']
    @owner_id = options['owner_id'].to_i if options["owner_id"]

  end

  def save()
    sql = "INSERT INTO animals
    (
      name,
      species,
      breed,
      received_date,
      adoptable,
      photo,
      owner_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6, $7
    )
    RETURNING id"
    values = [@name, @species, @breed, @received_date, @adoptable, @photo, @owner_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i

  end

  def delete()
    sql = "DELETE FROM animals
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def adoption_status()
   return "Not ready for adoption" if adoptable == "f" || nil
   return "Ready for adoption" if adoptable == "t" && owner_id == nil
   return "Adopted" if owner_id != nil
   end

    def set_adoptable_to_false()
      @adoptable = false
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
      received_date,
      adoptable

      ) =
      (
        $1, $2, $3, $4, $5
      )
      WHERE id = $6"
      values = [@name, @species, @breed, @received_date, @adoptable, @id]
      SqlRunner.run(sql, values)
    end

    def update_adoption()
      sql = "UPDATE animals
      SET
      (
        owner_id,
        adoptable
        ) =
        (
          $1, $2
        )
        WHERE id = $3"
        values = [@owner_id, @adoptable, @id]
        SqlRunner.run(sql, values)
      end

    def self.delete_all()
      sql = "DELETE FROM animals"
      SqlRunner.run(sql)
    end

    def self.find(id)
      sql = "SELECT * FROM animals
      WHERE id = $1"
      values = [id]
      result = SqlRunner.run(sql, values).first
      animal = Animal.new(result)
      return animal
    end

    def self.find_by_owner_id(owner_id)
      sql = "SELECT * FROM animals
      WHERE owner_id = $1"
      values = [owner_id]
      animal_hashes = SqlRunner.run(sql, values)
      animals = []
      for animal in animals
        animals.push(Animal.new(animal))
      end
      return animals
    end

    def self.find_by_species(species)
      sql = "SELECT * FROM animals
      WHERE species = $1"
      values = [species]
      result = SqlRunner.run(sql, values).first
      animal = Animal.new(result)
      return animal
    end

    def self.all()
      sql = "SELECT * FROM animals"
      result = SqlRunner.run( sql )
      animals = []
      for animal in result
        animals.push(Animal.new(animal))
      end
      return animals

    end

end
