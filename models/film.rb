require_relative('../db/sql_runner')

class Film

attr_accessor :id, :title, :price

  def initialize(db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @title = db_hash['title']
    @price = db_hash['price'].to_f
  end


  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING *"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)
    @id = film.first['id'].to_i
    end

  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    films = film_data.map{|film| Film.new(film)}
    return films
  end


  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
  sql = "DELETE FROM films where id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

end
