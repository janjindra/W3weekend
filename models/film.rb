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

  def show_all_customers_for_one_film
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id=customers.id
    WHERE tickets.film_id= $1 "
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return customer_data.map{|customer| Customer.new(customer)}
  end

  #Check how many customers are going to watch a certain film
  ##pry
  def number_of_customers_by_film()
    sql = "SELECT tickets.* FROM tickets
    WHERE film_id = $1"
    values = [@id]
    tickets_data = SqlRunner.run(sql, values)
    return (tickets_data.map{|ticket| Ticket.new(ticket)}).count
    end

#Write a method that finds out what is the most popular time (most tickets sold) for a given film
def most_popular_time_for_a_given_film
  sql = "SELECT screenings.show_time FROM tickets
      INNER JOIN screenings ON screenings.id=tickets.screening_id
      WHERE tickets.film_id = $1
      GROUP BY screenings.show_time
      ORDER BY count(distinct tickets.customer_id) desc"
  values = [@id]
  result =  SqlRunner.run(sql, values)
return result.map{|screening| Screening.new(screening)}.first.show_time

end


end
