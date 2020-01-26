require_relative('../db/sql_runner.rb')


class Screening

  attr_accessor :id, :show_time, :film_id, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @film_id = options['film_id'].to_i
    @capacity = options['capacity'].to_i
  end


  def save()
    sql = "INSERT INTO screenings (show_time, film_id, capacity) VALUES ($1, $2, $3) RETURNING *"
    values = [@show_time, @film_id, @capacity]
    screening = SqlRunner.run(sql, values)
    @id = screening.first['id'].to_i
    end

  def self.all()
    sql = "SELECT * FROM screenings"
    screening_data = SqlRunner.run(sql)
    screenings = screening_data.map{|scr| Screening.new(scr)}
    return screenings
  end


  def update()
    sql = "UPDATE screenings SET (show_time, film_id, capacity) = ($1, $2, $3) WHERE id = $4"
    values = [@show_time, @capacity, @id]
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

def capacity_check()
  sql = "SELECT tickets.id FROM tickets
  INNER JOIN screenings ON screenings.id=tickets.screening_id
  WHERE screenings.id = $1"
  values = [@id]
  db_output = SqlRunner.run(sql, values)
  currently_booked = db_output.map{|booking| Ticket.new(booking)}.count
  if @capacity > currently_booked
    return "Your ticket was booked!"
  end
   return "Sorry, the screening is fully booked."
end

end
