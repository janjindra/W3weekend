require_relative('../db/sql_runner.rb')


class Screening

  attr_accessor :id, :show_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @film_id = options['film_id'].to_i
  end


  def save()
    sql = "INSERT INTO screenings (show_time, film_id) VALUES ($1, $2) RETURNING *"
    values = [@show_time, @film_id]
    screening = SqlRunner.run(sql, values)
    @id = screening.first['id'].to_i
    end

  def self.all()
    sql = "SELECT * FROM screenings"
    screening_data = SqlRunner.run(sql)
    screenings = screening_data.map{|cust| Screening.new(cust)}
    return screenings
  end


  def update()
    sql = "UPDATE screenings SET (show_time, film_id) = ($1, $2) WHERE id = $3"
    values = [@show_time, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def delete()
  sql = "DELETE FROM screenings where id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

end
