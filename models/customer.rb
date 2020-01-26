
require_relative('../db/sql_runner.rb')


class Customer

  attr_accessor :id, :name, :funds, :tickets_list

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_f
    @tickets_list = []
  end


  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING *"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)
    @id = customer.first['id'].to_i
    end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    customers = customer_data.map{|cust| Customer.new(cust)}
    return customers
  end


  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
  sql = "DELETE FROM customers where id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def show_all_films_for_one_customer()
  sql = "SELECT * FROM films
  INNER JOIN tickets on films.id = tickets.film_id
  WHERE tickets.customer_id = $1"
  values = [@id]
  films_data = SqlRunner.run(sql, values)
  return films_data.map{|film| Film.new(film)}
end

#Buying tickets should decrease the funds of the customer by the price
def decrease_customer_funds_by_film_price(film)
  @funds -= film.price
end

#Check how many tickets were bought by a customer
##pry
  def number_of_tickets_by_customer()
  sql = "SELECT * from tickets
  WHERE customer_id = $1"
  values = [@id]
  tickets_data = SqlRunner.run(sql, values)
  return (tickets_data.map{|ticket| Ticket.new(ticket)}).count
end
##Ruby
  def add_tickets_to_a_customer(ticket)
    @tickets_list.push(ticket)
end



end
